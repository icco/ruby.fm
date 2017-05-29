# encoding: utf-8

class AudioUploader < ApplicationUploader
  require 'taglib'

  include Direct

  def base_store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}"
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{base_store_dir}/#{model.id}"
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

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
end
