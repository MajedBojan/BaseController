# frozen_string_literal: true

class JsonWebToken
  HMAC_SECRET = Rails.application.credentials.secret_key_base
  ALGORITHM   = 'HS256'

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:iat] = Time.zone.now.to_i
    payload[:exp] = exp.to_i

    JWT.encode(payload, HMAC_SECRET, ALGORITHM)
  end

  def self.decode(token)
    body = JWT.decode(token, HMAC_SECRET, true, algorithm: ALGORITHM)[0]
    HashWithIndifferentAccess.new(body)
  end
end
