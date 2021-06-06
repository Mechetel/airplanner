CarrierWave.configure do |config|
  config.fog_credentials = {
    # Configuration for Amazon S3
    :provider              => 'AWS',
    :aws_access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
    :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
    :region                => ENV['S3_REGION']
  }

  # For testing, upload files to local `tmp` folder.
  if Rails.env.test? || Rails.env.development?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog
  end

  config.cache_dir = Rails.root.join('/tmp/uploads')

  config.fog_directory    = ENV['S3_BUCKET_NAME']
  config.s3_access_policy = :public_read
  config.fog_host         = "#{ENV['S3_HOST_NAME']}/#{ENV['S3_BUCKET_NAME']}"
end
