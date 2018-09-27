Apipie.configure do |config|
  config.app_name                = 'BadiCodingChallengeBackend'
  config.api_base_url            = ''
  config.doc_base_url            = '/documentation'
  config.validate                = false
  config.translate               = false
  config.default_locale          = :en
  config.app_info['1.0'] = "API documentation for Badi's Coding Challenge Backend."
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
