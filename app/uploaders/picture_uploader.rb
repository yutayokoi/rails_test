class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_limit: [400, 400]

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  # アップロードされた画像の保存先を上書きする
  # マウントするデフォルトの保存先ディレクトリ
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # アップロード可能な拡張子のリスト
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end