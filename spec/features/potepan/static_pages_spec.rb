require 'rails_helper'

RSpec.feature "StaticPages", type: :feature do
  let!(:new_products) { create_list(:product, 8, available_on: 2.day.ago) }
  let!(:latest_product) { create(:product, available_on: 1.day.ago) }

  before do
    visit potepan_root_path
  end

  scenario "新着商品が新着順に8つ表示される" do
    within(:css, ".featuredProducts") do
      expect(page).to have_selector("h5", count: 8)
      expect(page).to have_selector("h3", count: 8)
      # 1番目の商品情報
      expect(page.all("h5")[0].text).to eq latest_product.name
      expect(page.all("h3")[0].text).to eq latest_product.display_price.to_s
      # 2-8番目の商品情報
      7.times do |i|
        expect(page.all("h5")[i + 1].text).to eq new_products[i].name
        expect(page.all("h3")[i + 1].text).to eq new_products[i].display_price.to_s
      end
      # 9番目以降は表示されない
      expect(page).not_to have_content new_products.last.name
    end
  end

  scenario "関連商品のひとつをクリックするとproductページに遷移する" do
    click_link latest_product.name
    expect(page).to have_css 'h2', text: latest_product.name
    within(:css, '.media-body') do
      expect(page).to have_content latest_product.name
      expect(page).to have_content latest_product.display_price.to_s
      expect(page).to have_content latest_product.description
    end
  end
end
