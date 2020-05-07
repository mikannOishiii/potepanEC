require 'rails_helper'

RSpec.describe Potepan::StaticPagesController, type: :controller do
  describe "GET #home" do
    let!(:new_products) { create_list(:product, 8, available_on: 2.day.ago) }
    let!(:latest_product) { create(:product, available_on: 1.day.ago) }

    before do
      get :home
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "homeテンプレートで表示されること" do
      expect(response).to render_template(:home)
    end

    it "新着商品が8個取得できていること" do
      expect(assigns(:new_products).length).to eq 8
    end

    it "新着商品が新着順に取得できていること" do
      expect(assigns(:new_products).first).to eq latest_product
      expect(assigns(:new_products).from(1)).to eq new_products[0..6]
    end
  end
end
