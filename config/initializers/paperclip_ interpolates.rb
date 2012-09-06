require "digest"

Paperclip.interpolates :hashed_path do |attachment, style|
  hash = Digest::MD5.hexdigest(attachment.instance.id.to_s)
  return "#{hash.slice!(0..3)}"
end

# 根据ID生成唯一的文件名
Paperclip.interpolates :hash_name do |attachment, style|
  return Digest::MD5.hexdigest(attachment.instance.id.to_s)[1..12]
end