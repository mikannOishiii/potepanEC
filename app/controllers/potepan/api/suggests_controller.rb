class Potepan::Api::SuggestsController < Potepan::ApiController
  before_action :authenticate

  def index
    keyword = params[:keyword]
    max_num = params[:max_num]
    keywords = Potepan::Suggest.
      where("keyword like ?", "#{keyword}%").take(max_num).pluck(:keyword)
    render json: keywords
  end
end
