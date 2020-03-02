require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  let(:product) { FactoryBot.create(:product) }

  describe 'GET #show' do
    # 正常にレスポンスを返すこと
    it "returns http success" do
      get :show, params: { id: product.id }
      aggregate_failures do
        expect(response).to have_http_status(:success)
        expect(response).to have_http_status "200"
      end
    end
  end
end
