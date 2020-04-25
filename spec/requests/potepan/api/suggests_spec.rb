require 'rails_helper'

RSpec.describe Potepan::Api::SuggestsController, type: :request do
  let!(:match_keywords_rails) { create_list(:potepan_suggest, 5) }
  let!(:not_match_keyword_rails) { create(:potepan_suggest, keyword: "apache") }

  describe "SuggestAPI" do
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
        expect(json_response.length).to eq 5
        expect(json_response).to eq ["rails6", "rails7", "rails8", "rails9", "rails10"]
      end

      it "正しくないデータは返さない" do
        expect(json_response).not_to include "apache"
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
        expect(json_response).to eq "API key authentication failed"
      end
    end
  end
end
