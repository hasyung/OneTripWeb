# encoding: utf-8

class VideoUploader < CarrierWave::Uploader::Base
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
  
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

end