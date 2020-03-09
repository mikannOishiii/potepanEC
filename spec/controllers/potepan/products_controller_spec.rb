require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  let(:product) { create(:product) }

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
  end
end
