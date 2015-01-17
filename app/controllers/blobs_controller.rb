class BlobsController < ApplicationController
  def new
    headers = {}
    options = { path_style: true, acl: :public_read, success_action_status: 201 }
    expires = Chronic.parse('in 10 minutes').to_i
    @path = "/#{SecureRandom.hex(13)}/${filename}"
    @url = S3.put_object_url(S3_DIR.key, @path, expires, headers, options)
    @blob = Blob.new
  end
end
