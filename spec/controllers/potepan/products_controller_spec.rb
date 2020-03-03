require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  let(:product) { FactoryBot.create(:product) }

  describe 'GET #show' do
    it "正常にレスポンスを返すこと" do
      get :show, params: { id: product.id }
      expect(response).to have_http_status(:success)
    end
    it "正しい商品情報を表示すること" do
      get :show, params: { id: product.id }
      expect(product.name).to eq product.name
      expect(product.display_price).to eq product.display_price
      expect(product.description).to eq product.description
    end
    it "showテンプレートで表示されること" do
      get :show, params: { id: product.id }
      expect(response).to render_template(:show)
    end
    it '@productが取得できていること' do
      get :show, params: { id: product.id }
      expect(assigns(:product)).to eq product
    end
  end
end
