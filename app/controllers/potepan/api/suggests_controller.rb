class Potepan::Api::SuggestsController < Potepan::ApiController
  before_action :authenticate

  def index
    keyword = params[:keyword]
    max_num = params[:max_num]
    if keyword.present?
      query = Potepan::Suggest.where("keyword like ?", "#{keyword}%")
      query = query.take(max_num) if max_num.to_i >= 1
      render json: query.pluck(:keyword)
    else
      render file: Rails.root.join("public/500.html"), status: 500, layout: false, content_type: "text/html"
    end
  end
end
