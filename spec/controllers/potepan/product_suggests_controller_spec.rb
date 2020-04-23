require 'rails_helper'

RSpec.describe Potepan::ProductSuggestsController, type: :controller do
  describe "GET #index" do
    url = Rails.application.credentials.presite[:PRESITE_URL]
    key = Rails.application.credentials.presite[:PRESITE_API_KEY]

    context "status code が 200 OK の場合" do
      before do
        stub_request(:get, url).
          with(
            headers: { "Authorization" => "Bearer #{key}" },
            query: hash_including({ :keyword => "rails", :max_num => "5" })
          ).to_return(status: 200, body: ["rails", "rails for women", "rails for men"])
        get :index, params: { keyword: "rails", max_num: 5 }
      end

      it 'stubの中身が取得できている' do
        expect(WebMock).to have_requested(:get, url).
          with(
            headers: { "Authorization" => "Bearer #{key}" },
            query: { keyword: "rails", max_num: "5" }
          )
      end

      it "レスポンスが正常に返されている(200ok)" do
        expect(response).to have_http_status 200
      end

      it "keywords(= res.body)が取得できている" do
        json = JSON.parse(response.body)
        expect(json).to eq ["rails", "rails for women", "rails for men"]
      end
    end

    context "status code がエラー(例.500)の場合" do
      before do
        stub_request(:get, url).
          with(
            headers: { "Authorization" => "Bearer #{key}" },
            query: hash_including({ keyword: "rails", max_num: "5" })
          ).to_return(
            status: 500,
            body: "error message"
          )
        get :index, params: { keyword: "rails", max_num: 5 }
      end

      it "レスポンスが正常に返されている(500error)" do
        expect(response).to have_http_status 500
      end

      it "エラーメッセージが返される" do
        expect(response.body).to eq "error message"
      end
    end
  end
end
