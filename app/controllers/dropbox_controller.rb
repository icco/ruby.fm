require 'dropbox_sdk'
require 'securerandom'

require 'open-uri'
require 'stringio'
require 'net/http'
require 'uri'
require 'mp3info'

APP_KEY = "3da9yeowjg8366f"
APP_SECRET = "i93ugwid0g4emrl"

class DropboxController < ApplicationController

    def index
    end

    def main
        client = get_dropbox_client
        unless client
            redirect_to(:action => 'auth_start') and return
        end

        account_info = client.account_info

        # Grab an array of files
        files = client.metadata('/')["contents"]

        # Get a URL for the demo
        demo = client.media(files.first["path"])["url"]

        # url = URI.parse(demo.to_s) # turn the string into a URI
        # url = URI.parse('http://www.maninblack.org/demos/WhereDoAllTheJunkiesComeFrom.mp3') # turn the string into a URI
        url = URI.parse(demo.to_s) # turn the string into a URI
        http = Net::HTTP.new(url.host, url.port) 
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE if http.use_ssl?
        req = Net::HTTP::Get.new(url.path) # init a request with the url
        req.range = (0..4096) # limit the load to only 4096 bytes
        res = http.request(req) # load the mp3 file
        child = {} # prepare an empty array to store the metadata we grab

        Mp3Info.open( StringIO.open(res.body) ) do |m|  #do the parsing
          child['title'] = m.tag.title 
          child['album'] = m.tag.album 
          child['artist'] = m.tag.artist
          child['length'] = m.length 
          child['date'] = m.tag.year 
        end

        @child = child
        @child_url = demo

        # render :inline =>
            "#{account_info['email']}
            <br>
            #{demo}
            <br>
            #{child["title"]}
            "
    end

    def upload
        client = get_dropbox_client
        unless client
            redirect_to(:action => 'auth_start') and return
        end

        begin
            # Upload the POST'd file to Dropbox, keeping the same name
            resp = client.put_file(params[:file].original_filename, params[:file].read)
            render :text => "Upload successful.  File now at #{resp['path']}"
        rescue DropboxAuthError => e
            session.delete(:access_token)  # An auth error means the access token is probably bad
            logger.info "Dropbox auth error: #{e}"
            render :text => "Dropbox auth error"
        rescue DropboxError => e
            logger.info "Dropbox API error: #{e}"
            render :text => "Dropbox API error"
        end
    end

    def get_dropbox_client
        if session[:access_token]
            begin
                access_token = session[:access_token]
                DropboxClient.new(access_token)
            rescue
                # Maybe something's wrong with the access token?
                session.delete(:access_token)
                raise
            end
        end
    end

    def get_web_auth()
        redirect_uri = url_for(:action => 'auth_finish')
        DropboxOAuth2Flow.new(APP_KEY, APP_SECRET, redirect_uri, session, :dropbox_auth_csrf_token)
    end

    def auth_start
        authorize_url = get_web_auth().start()

        # Send the user to the Dropbox website so they can authorize our app.  After the user
        # authorizes our app, Dropbox will redirect them here with a 'code' parameter.
        redirect_to authorize_url
    end

    def auth_finish
        begin
            access_token, user_id, url_state = get_web_auth.finish(params)
            session[:access_token] = access_token
            redirect_to :action => 'main'
        rescue DropboxOAuth2Flow::BadRequestError => e
            render :text => "Error in OAuth 2 flow: Bad request: #{e}"
        rescue DropboxOAuth2Flow::BadStateError => e
            logger.info("Error in OAuth 2 flow: No CSRF token in session: #{e}")
            redirect_to(:action => 'auth_start')
        rescue DropboxOAuth2Flow::CsrfError => e
            logger.info("Error in OAuth 2 flow: CSRF mismatch: #{e}")
            render :text => "CSRF error"
        rescue DropboxOAuth2Flow::NotApprovedError => e
            render :text => "Not approved?  Why not, bro?"
        rescue DropboxOAuth2Flow::ProviderError => e
            logger.info "Error in OAuth 2 flow: Error redirect from Dropbox: #{e}"
            render :text => "Strange error."
        rescue DropboxError => e
            logger.info "Error getting OAuth 2 access token: #{e}"
            render :text => "Error communicating with Dropbox servers."
        end
    end
end
