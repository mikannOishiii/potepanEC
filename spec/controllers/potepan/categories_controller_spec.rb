require 'rails_helper'

RSpec.describe Potepan::CategoriesController, type: :controller do
  include_context "category setup"

  describe "GET #show" do
    before do
      get :show, params: { id: taxon1.id }
    end

    it "正常にレスポンスを返すこと" do
      expect(response).to have_http_status(:success)
    end

    it "showテンプレートで表示されること" do
      expect(response).to render_template(:show)
    end

    it '@categoryが取得できていること' do
      expect(assigns(:category)).to eq taxon1
    end

    it '@productsが取得できていること' do
      expect(assigns(:products)).to eq taxon1.products
    end
  end
end
