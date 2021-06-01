module JwtToken
  extend ActiveSupport::Concern

  SECRET_KEY = Rails.application.credentials.secret_key_base

  def encode
    exp = 1.month.from_now.to_i
    payload = { user_id: id, exp: exp }
    JWT.encode(payload, SECRET_KEY)
  end

  class_methods do
    def decode(token)
      JWT.decode(token, SECRET_KEY).first
    end
  end
end
