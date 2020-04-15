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
    status = res.status_code
    keywords = res.body
    if status == 200
      render json: keywords
    else
      raise "response failed. ErrCode: #{status} / ErrMessage: #{keywords}"
    end
  end
end
