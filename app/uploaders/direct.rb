module Direct
  FILENAME_WILDCARD = "${filename}"

  def s3_bucket
    @s3_bucket ||= Aws::S3::Resource.new.bucket(ENV['S3_BUCKET'])
  end

  # This is not the same as above. It is used for direct uploading. Not for
  # carrier wave
  def s3_store_dir
    if model.id.present?
      "/#{base_store_dir}/#{model.id}"
    else
      "/#{base_store_dir}/#{SecureRandom.uuid}"
    end
  end

  def s3_post
    s3_bucket.presigned_post({
      key: s3_store_dir,
      success_action_status: '201',
      acl: 'public-read'
    })
  end
end
