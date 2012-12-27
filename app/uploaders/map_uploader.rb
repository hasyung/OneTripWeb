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
  
  version :thumb do
    process :resize_to_limit => [250, 150]
  end

  version :thumb_middle do
    process :resize_to_limit => [480, 270]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    if original_filename
      # current_path 是 Carrierwave 上传过程临时创建的一个文件，有时间标记，所以它将是唯一的
      @name ||= Digest::MD5.hexdigest(File.dirname(current_path))
      "#{@name}.#{file.extension}"
    end
  end
end