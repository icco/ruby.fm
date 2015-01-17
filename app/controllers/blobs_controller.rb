class BlobsController < ApplicationController
  def new
    @bucket = "http://#{S3_DIR.key}.s3.amazonaws.com/"
    headers = {}
    options = { path_style: true, acl: :public_read, success_action_status: 201 }
    expires = Chronic.parse('in 10 minutes').to_i
    @path = "/#{SecureRandom.uuid}/${filename}"
    @url = S3.signed_url(options.merge({
      :bucket_name => S3_DIR.key,
      :object_name => @path,
      :method   => 'POST',
      :headers  => headers,
    }), expires)
    @blob = Blob.new
  end
end
