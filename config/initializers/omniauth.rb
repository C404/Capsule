Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '138038139669724', '65e4acabaa1e551adb7b8908f18792b7'
end
