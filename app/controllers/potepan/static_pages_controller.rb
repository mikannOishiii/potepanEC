class Potepan::StaticPagesController < ApplicationController
  def home
  end

  def suggest
    require 'httpclient'
    url = Rails.application.credentials.presite[:PRESITE_URL]
    key = Rails.application.credentials.presite[:PRESITE_API_KEY]
    client = HTTPClient.new
    header = { "Authorization" => "Bearer #{key}" }
    query = { 'keyword' => params[:keyword], 'max_num' => params[:max_num] }
    res = client.get(url, query, header)
    @keywords = res.body
    render json: @keywords
  end
end
