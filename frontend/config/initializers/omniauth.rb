Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :facebook, '138038139669724', '65e4acabaa1e551adb7b8908f18792b7'
  # provider :dailymotion, '775f318f3c42669281b3', '6946c5cc4aba6b70c6958e4edb2a80c067d5148a'



  provider :facebook, '217671128363946', '40bc81524f57570e65ce9fc7aef4a9bd'

  login_provider = :dailymotion
  client_id = '4a441d23f4457e6a501d'
  secret_id = '64d03bf136c3509839cf5a8cea185bc70c6cabfb'
  provider login_provider, client_id, secret_id

end
