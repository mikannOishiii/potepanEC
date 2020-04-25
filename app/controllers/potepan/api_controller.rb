class Potepan::ApiController < ActionController::API
  # authenticate_with_http_token を使用するために必要
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate

  protected

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |bearer, options|
      key = Rails.application.credentials.presite[:PRESITE_API_KEY]
      secure_compare(bearer, key)
    end
  end

  def render_unauthorized
    error_message = "API key authentication failed"
    render json: error_message.to_json, status: :unauthorized
  end

  def secure_compare(a, b)
    return false unless a.bytesize == b.bytesize
    l = a.unpack("C*")
    r, i = 0, -1
    b.each_byte { |v| r |= v ^ l[i += 1] }
    r == 0
  end
end
