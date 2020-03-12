require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'full title helper' do
    it "ページタイトルがないときサイトタイトルのみを返す" do
      expect(full_title("")).to eq "POTEPAN BIGBAG Store"
    end

    it "ページタイトルがnilのときサイトタイトルのみを返す" do
      expect(full_title(nil)).to eq "POTEPAN BIGBAG Store"
    end

    it "ページタイトルがあるときページタイトルとサイトタイトルを返す" do
      expect(full_title("ページタイトル")).to eq "ページタイトル - POTEPAN BIGBAG Store"
    end
  end
end
