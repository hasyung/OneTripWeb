# encoding: utf-8

class VideoCoverUploader < CarrierWave::Uploader::Base
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
  
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}"
  end
  
   def default_url
    asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  end

  process :set_content_type

  version :default do
  end
  
  version :thumb do
    process :resize_to_limit => [250, 150]
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