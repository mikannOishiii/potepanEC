require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe 'GET #show' do
    let(:product) { FactoryBot.create(:product) }

    it "returns http success" do
      get :show, params: { id: product.id }
      expect(response).to have_http_status(:success)
    end
  end
end
