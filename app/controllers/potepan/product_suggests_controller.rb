class Potepan::ProductSuggestsController < ApplicationController
  def index
    require "httpclient"
    url = Rails.application.credentials.presite[:PRESITE_URL]
    key = Rails.application.credentials.presite[:PRESITE_API_KEY]
    client = HTTPClient.new
    header = { "Authorization" => "Bearer #{key}" }
    query = { "keyword" => params[:keyword], "max_num" => params[:max_num] }
    res = client.get(url, query, header)
    keywords = res.body
    status = res.status_code
    if status == 200
      render json: keywords
    else
      render json: keywords, status: status
    end
  end
end
