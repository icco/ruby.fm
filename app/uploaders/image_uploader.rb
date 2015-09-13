# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

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
end
