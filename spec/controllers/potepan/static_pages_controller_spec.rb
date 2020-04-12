require 'rails_helper'

RSpec.describe Potepan::StaticPagesController, type: :controller do
  describe "GET #home" do
    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #suggest" do
    url = "https://presite-potepanec-task5.herokuapp.com/potepan/api/suggests"

    before do
      stub_request(:get, url).
        with(
          headers: { 'Authorization' => 'Bearer api123' },
          query: hash_including({ :keyword => 'rails', :max_num => '5' })
        ).to_return(status: 200, body: ["rails", "rails for women", "rails for men"])
      get :suggest, params: { keyword: "rails", max_num: 5 }
    end

    it 'stubの中身が合っている' do
      expect(WebMock).to have_requested(:get, url).
        with(
          headers: { "Authorization" => "Bearer api123" },
          query: { keyword: "rails", max_num: "5" }
        )
    end

    it "レスポンスが正常に返されている" do
      expect(response).to have_http_status 200
    end

    it "@keywordsが取得できている" do
      expect(assigns(:keywords)).to eq ["rails", "rails for women", "rails for men"]
    end
  end
end
