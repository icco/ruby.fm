# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :aws

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  def default_s3_path
    "images/fallback.jpg"
  end

  def s3_path
    current_path || default_s3_path
  end

  def default_url
    "https://rubyfm-blobs.s3.amazonaws.com/images/fallback.jpg"
  end

  def store_dir
    "images/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "#{Rails.root}/tmp/images"
  end

  def extension_white_list
    %w(png jpg)
  end

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
