class ApplicationUploader < CarrierWave::Uploader::Base
  storage :aws
end
