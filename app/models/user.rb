class User < ApplicationRecord
  has_secure_password

  def payload
    {
      id: id,
      email: email,
      exp: (Time.zone.now + 1.week).to_i
    }
  end

  def jwt
    secret = Rails.application.secrets['secret_key_base']
    JWT.encode(hash, secret, 'HS384')
  end
end
