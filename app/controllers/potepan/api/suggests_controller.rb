class Potepan::Api::SuggestsController < Potepan::ApiController
  before_action :authenticate

  def index
    keyword = params[:keyword]
    max_num = params[:max_num]
    if keyword.present?
      if max_num.to_i >= 1
        keywords = Potepan::Suggest.
          where("keyword like ?", "#{keyword}%").take(max_num).pluck(:keyword)
        render json: keywords
      else
        keywords = Potepan::Suggest.
          where("keyword like ?", "#{keyword}%").pluck(:keyword)
        render json: keywords
      end
    else
      render file: Rails.root.join("public/500.html"), status: 500, layout: false, content_type: "text/html"
    end
  end
end
