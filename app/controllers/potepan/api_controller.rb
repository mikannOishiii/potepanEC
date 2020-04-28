class Potepan::ApiController < ActionController::API
  # authenticate_with_http_token を使用するために必要
  include ActionController::HttpAuthentication::Token::ControllerMethods

  require "active_support/security_utils"

  protected

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |bearer, options|
      key = Rails.application.credentials.presite[:PRESITE_API_KEY]
      ActiveSupport::SecurityUtils.secure_compare(bearer, key)
    end
  end

  def render_unauthorized
    error_message = "API key authentication failed"
    render json: error_message.to_json, status: :unauthorized
  end
end
