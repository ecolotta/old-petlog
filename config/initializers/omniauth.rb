Rails.application.config.middleware.use OmniAuth::Builder do
  provider :line, ENV['LINE_LOGIN_ID'], ENV['LINE_LOGIN_SECRET']
end
