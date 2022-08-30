if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider => 'AWS',
      :aws_access_key_id => Rails.application.credentials.dig(:aws, :public_key),
      :aws_secret_access_key => Rails.application.credentials.dig(:aws, :secret_key),
    }
    config.fog_directory = Rails.application.credentials.dig(:aws, :s3_bucket)
  end
end

