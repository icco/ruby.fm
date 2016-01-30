# encoding: utf-8

class AudioUploader < CarrierWave::Uploader::Base
  require 'taglib'

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :aws

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(mp3)
  end

  process :add_id3_tags

  def add_id3_tags
    TagLib::FileRef.open(file.path) do |fileref|
      unless fileref.null?
        tag = fileref.tag
        model.title = tag.title
        if tag.title.nil? && original_filename.present?
          model.title = File.basename(original_filename, '.*')
        end
        # tag.artist
        # tag.album
        # tag.year
        # tag.track
        # tag.genre
        # tag.comment
        model.notes = tag.comment

        properties = fileref.audio_properties
        # properties.length
        model.length = properties.length
        model.save
      end
    end
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
