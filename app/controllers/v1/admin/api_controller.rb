# frozen_string_literal: true

class V1::Admin::ApiController < ApplicationController
  include JsonResponders
  include ExceptionHandler
  include MissingData

  before_action :authenticate!
  before_action :set_locale
  require_power_check

  self.responder = ApplicationResponder

  private

  def authenticate!
    return if missing_headers!('Authorization')

    @current_user = AuthenticateUser.get(request.headers['Authorization'].split(' ').last)
  end

  # Set request locale
  def set_locale
    I18n.locale = params[:locale] || request.headers['locale'] || I18n.default_locale
  end
end
