require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe 'GET #show' do
    before do
      product = FactoryBot.create(:product)
      get :show, params: { id: product.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end
end
