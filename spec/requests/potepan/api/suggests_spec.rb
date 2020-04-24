require 'rails_helper'

RSpec.describe Potepan::Api::SuggestsController, type: :request do
  let!(:suggest1) { create(:potepan_suggest, keyword: "rails1") }
  let!(:suggest2) { create(:potepan_suggest, keyword: "rails2") }
  let!(:suggest3) { create(:potepan_suggest, keyword: "rails3") }
  let!(:suggest4) { create(:potepan_suggest, keyword: "rails4") }
  let!(:suggest5) { create(:potepan_suggest, keyword: "rails5") }
  let!(:suggest6) { create(:potepan_suggest, keyword: "rails6") }

  describe 'SuggestAPI' do
    key = Rails.application.credentials.presite[:PRESITE_API_KEY]

    context "status code が 200 OK の場合" do
      before do
        get "/potepan/api/suggests", params: { keyword: "rails", max_num: 5 },
                                     headers: { "Authorization" => "Bearer #{key}" }
      end

      it "正しいレスポンスを返している（200ok）" do
        expect(response).to have_http_status 200
      end

      it "正しいデータを取得して返している" do
        json = JSON.parse(response.body)
        expect(json.length).to eq 5
        expect(json).to eq ["rails1", "rails2", "rails3", "rails4", "rails5"]
        expect(json).not_to include "rails6"
      end
    end

    context "status code が 401 error の場合" do
      before do
        get "/potepan/api/suggests", params: { keyword: "rails", max_num: 5 },
                                     headers: { "Authorization" => "Bearer invalid" }
      end

      it "正しいレスポンスを返している（401Unauthorized）" do
        expect(response).to have_http_status 401
      end

      it "エラーメッセージを返している" do
        json = JSON.parse(response.body)
        expect(json).to eq "API key authentication failed"
      end
    end
  end
end
