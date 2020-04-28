require 'rails_helper'

RSpec.describe Potepan::Api::SuggestsController, type: :request do
  let!(:match_keywords_rails) { create_list(:potepan_suggest, 6) }
  let!(:not_match_keyword_rails) { create(:potepan_suggest, keyword: "apache") }

  shared_context 'json_response' do
    let(:json_response) { JSON.parse(response.body) }
  end

  describe "SuggestAPI" do
    key = Rails.application.credentials.presite[:PRESITE_API_KEY]
    include_context "json_response"

    context "リクエストに成功した場合" do
      before do
        get "/potepan/api/suggests", params: { keyword: "rails", max_num: 5 },
                                     headers: { "Authorization" => "Bearer #{key}" }
      end

      it "ステータスコードは200を返す" do
        expect(response).to have_http_status 200
      end

      it "検索マッチしたキーワードを5件返す" do
        expect(json_response.length).to eq 5
        expect(json_response).to eq match_keywords_rails.take(5).pluck(:keyword)
        # 検索マッチしても6番目以降のキーワードは返されない
        expect(json_response).not_to include match_keywords_rails.last.keyword
      end

      it "検索マッチしないキーワードは返さない" do
        expect(json_response).not_to include not_match_keyword_rails.keyword
      end
    end

    context "リクエストに成功した場合（max_numがnil）" do
      before do
        get "/potepan/api/suggests", params: { keyword: "rails", max_num: nil },
                                     headers: { "Authorization" => "Bearer #{key}" }
      end

      it "ステータスコードは200を返す" do
        expect(response).to have_http_status 200
      end

      it "検索マッチしたキーワードを全件返す" do
        expect(json_response).to eq match_keywords_rails.pluck(:keyword)
      end

      it "検索マッチしないキーワードは返さない" do
        expect(json_response).not_to include not_match_keyword_rails.keyword
      end
    end

    context "リクエストに失敗した場合（keywordパラメータ不設定）" do
      before do
        get "/potepan/api/suggests", params: { max_num: 5 },
                                     headers: { "Authorization" => "Bearer #{key}" }
      end

      it "ステータスコードは500を返す" do
        expect(response).to have_http_status 500
      end

      it "500エラーページを返す" do
        expect(response.content_type).to eq "text/html"
        expect(response.body).to include "We're sorry, but something went wrong."
      end
    end

    context "リクエストに失敗した場合（トークン認証失敗）" do
      before do
        get "/potepan/api/suggests", params: { keyword: "rails", max_num: 5 },
                                     headers: { "Authorization" => "Bearer invalid" }
      end

      it "ステータスコードは401を返す" do
        expect(response).to have_http_status 401
      end

      it "エラーメッセージを返す" do
        expect(json_response).to eq "API key authentication failed"
      end
    end
  end
end
