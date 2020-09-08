# frozen_string_literal: true

class Authentication
  attr_reader :token, :klass

  def initialize(klass, token)
    @klass = klass
    @token = token
  end

  def self.get(token)
    new(token).get
  end

  def get
    # inactive_user!
    user
  end

  private

  def user
    @user ||= klass.find(decoded_token[:id]) if decoded_token
  rescue ActiveRecord::RecordNotFound
    raise(CustomException::AuthUserNotFound)
  end

  def decoded_token
    missing_token!
    @decoded_token ||= JsonWebToken.decode(token)
  end

  def missing_token!
    raise(CustomException::MissingToken) unless token.present?
  end

  # def inactive_user!
  #   raise(CustomException::InactiveAccount) unless user.active?
  # end
end
