 CarrierWave.configure do |config|
  if Rails.env.test? || Rails.env.development?
    config.storage = :file
  else
    config.cache_dir = "#{Rails.root}/tmp/uploads"
    config.storage = :fog
    config.fog_credentials = {
      :provider => 'AWS',
      :aws_access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
      :region => ENV['S3_REGION'],
    }
    config.fog_directory = ENV['S3_BUCKET_NAME']
    config.cache_dir = "#{Rails.root}/tmp/uploads"
  end
end
