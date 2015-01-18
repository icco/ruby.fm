# From https://github.com/railscasts/383-uploading-to-amazon-s3/blob/master/gallery-jquery-fileupload/app/helpers/upload_helper.rb
module UploadHelper
  def s3_uploader_form(options = {})
    uploader = S3Uploader.new(options)
  end

  class S3Uploader
    def form(&block)
      form_tag(self.url, self.form_options) do
        self.fields.map do |name, value|
          hidden_field_tag(name, value)
        end.join.html_safe + capture(&block)
      end
    end

    def initialize(options)
      @options = options.reverse_merge(
        id: "fileupload",
        aws_access_key_id: S3_OPTIONS[:aws_access_key_id],
        aws_secret_access_key: S3_OPTIONS[:aws_secret_access_key],
        bucket: S3_DIR.key,
        acl: "public-read",
        expiration: 10.hours.from_now,
        max_file_size: 500.megabytes,
        as: "file"
      )
    end

    def form_options
      {
        id: @options[:id],
        method: "post",
        authenticity_token: false,
        multipart: true,
        class: @options[:class],
        data: {
          post: @options[:post],
          as: @options[:as]
        }
      }
    end

    def fields
      {
        "AWSAccessKeyId" => @options[:aws_access_key_id],
        :acl => @options[:acl],
        :key => key,
        :policy => policy,
        :signature => signature,
        :success_action_status => 201,
      }
    end

    def key
      @key ||= "uploads/#{SecureRandom.hex}/${filename}"
    end

    def url
      "https://#{@options[:bucket]}.s3.amazonaws.com/"
    end

    def policy
      Base64.encode64(policy_data.to_json).gsub("\n", "")
    end

    def policy_data
      {
        expiration: @options[:expiration],
        conditions: [
          ["starts-with", "$key", "uploads/"],
          {success_action_status: '201'},
          ["content-length-range", 0, @options[:max_file_size]],
          {bucket: @options[:bucket]},
          {acl: @options[:acl]}
        ]
      }
    end

    def signature
      Base64.encode64(
        OpenSSL::HMAC.digest(
          OpenSSL::Digest::Digest.new('sha1'),
          @options[:aws_secret_access_key], policy
        )
      ).gsub("\n", "")
    end
  end
end