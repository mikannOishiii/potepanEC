class Potepan::Api::SuggestsController < ApplicationController
  before_action :authenticate

  def index
    keyword = params[:keyword]
    max_num = params[:max_num]
    keywords = Potepan::Suggest.where("keyword like ?", "#{keyword}%").take(max_num)
    data = keywords.pluck(:keyword)
    render json: data
  end
end
