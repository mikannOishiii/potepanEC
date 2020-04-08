class Potepan::StaticPagesController < ApplicationController
  def home
  end

  def suggest
    require 'httpclient'
    url = Rails.application.credentials.presite[:PRESITE_URL]
    key = Rails.application.credentials.presite[:PRESITE_API_KEY]
    client = HTTPClient.new
    header = { "Authorization" => "Bearer #{key}" }
    query = { 'keyword' => params[:term], 'max_num' => '5' }
    res = client.get(url, query, header)
    @keywords = res.body
    render json: @keywords
  end
end
