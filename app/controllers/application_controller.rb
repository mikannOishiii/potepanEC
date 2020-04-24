class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # authenticate_with_http_token を使用するために必要
  include ActionController::HttpAuthentication::Token::ControllerMethods

  private

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |bearer, options|
      bearer == Rails.application.credentials.presite[:PRESITE_API_KEY]
    end
  end

  def render_unauthorized
    error_message = "API key authentication failed"
    render json: error_message.to_json, status: :unauthorized
  end
end
