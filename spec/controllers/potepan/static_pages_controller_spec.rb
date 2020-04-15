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

    context "status code が 200 OK の場合" do
      before do
        stub_request(:get, url).
          with(
            headers: { 'Authorization' => 'Bearer api123' },
            query: hash_including({ :keyword => 'rails', :max_num => '5' })
          ).to_return(status: 200, body: ["rails", "rails for women", "rails for men"])
        get :suggest, params: { keyword: "rails", max_num: 5 }
      end

      it 'stubの中身が取得できている' do
        expect(WebMock).to have_requested(:get, url).
          with(
            headers: { "Authorization" => "Bearer api123" },
            query: { keyword: "rails", max_num: "5" }
          )
      end

      it "レスポンスが正常に返されている" do
        expect(response).to have_http_status 200
      end

      it "keywords(= res.body)が取得できている" do
        expect(response.body).to eq "[\"rails\",\"rails for women\",\"rails for men\"]"
      end
    end

    context "status code がエラーの場合" do
      before do
        stub_request(:get, url).
          with(
            headers: { 'Authorization' => 'Bearer api123' },
            query: hash_including({ :keyword => 'rails', :max_num => '5' })
          ).to_raise(StandardError.new("response failed. ErrCode: hoge / ErrMessage: hoge"))
      end

      it "レスポンスエラーが返されている" do
        expect { get :suggest, params: { keyword: "rails", max_num: 5 } }.
          to raise_error("response failed. ErrCode: hoge / ErrMessage: hoge")
      end
    end
  end
end
