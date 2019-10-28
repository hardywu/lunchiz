class User < ApplicationRecord
  has_secure_password
  has_many :reviews
  validates :email, uniqueness: true, email: true
  validates :username, uniqueness: true
  validates :username, presence: true
  default_scope { order(created_at: :desc) }

  def payload
    {
      id: id,
      email: email,
      exp: (Time.zone.now + 1.week).to_i
    }
  end

  def jwt
    JWT.encode(payload, Rails.application.credentials.secret_key_base, 'HS384')
  end

  def self.of_jwt(token)
    secret = Rails.application.secrets['secret_key_base']
    find JWT.decode(token, secret, true, algorithm: 'HS384')[0]['id']
  rescue JWT::DecodeError
    nil
  end
end
