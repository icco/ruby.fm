class BlobsController < ApplicationController
  def new
    headers = {}
    options = { path_style: true, acl: :public_read, success_action_status: 201, success_action_redirect: "#{request.host_with_port}/success" }
    path = "#{SecureRandom.uuid}/${filename}"
    @url = S3.put_object_url(ENV['S3_BUCKET'], path, Chronic.parse('next week'), headers, options)
    @blob = Blob.new
  end
end
