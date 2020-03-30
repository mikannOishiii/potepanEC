require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  let!(:taxon) { create(:taxon) }
  let!(:product) { create(:product, taxons: [taxon]) }
  let!(:related_products) { create_list(:product, 5, taxons: [taxon]) }

  describe 'GET #show' do
    before do
      get :show, params: { id: product.id }
    end

    it "正常にレスポンスを返すこと" do
      expect(response).to have_http_status(:success)
    end

    it "showテンプレートで表示されること" do
      expect(response).to render_template(:show)
    end

    it '@productが取得できていること' do
      expect(assigns(:product)).to eq product
    end

    it '関連商品は4つ取得できていること' do
      expect(assigns(:related_products).length).to eq 4
    end
  end
end
