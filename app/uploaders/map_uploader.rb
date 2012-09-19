# encoding: utf-8

class MapUploader < CarrierWave::Uploader::Base

  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
  
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}"
  end

  def default_url
    asset_path("default/#{model.class.to_s.underscore}/" + [version_name, "default.png"].compact.join('_'))
  end

  process :set_content_type

  version :default do
    process :resize_to_limit => [800, 500]
  end

  version :thumb do
    process :resize_to_limit => [250, 141]
  end

  version :thumb_middle do
    process :resize_to_limit => [478, 280]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    if original_filename
      @name ||= Digest::MD5.hexdigest(File.dirname(current_path))
      "#{@name}.#{file.extension}"
    end
  end

end
