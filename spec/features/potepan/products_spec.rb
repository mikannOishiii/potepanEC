require 'rails_helper'

RSpec.feature "Products", type: :feature do
  include_context "product setup"

  before do
    visit potepan_product_path(product1.id)
  end

  scenario "動的に商品情報が表示される" do
    expect(page).to have_title full_title(product1.name)
    within(:css, '.media-body') do
      expect(page).to have_content product1.name
      expect(page).to have_content product1.display_price.to_s
      expect(page).to have_content product1.description
    end
  end

  scenario "商品ページに関連商品情報が4つ表示される" do
    expect(page).to have_selector(".productBox", count: 4)
    expect(page).to have_selector(".productImage", count: 4)
    expect(page).to have_selector(".productCaption", count: 4)
    # product1と100%カテゴリ一致する商品は必ず表示される
    expect(page).to have_content product6.name
    # product1と同じカテゴリに属さない商品は表示されない
    expect(page).not_to have_content other_product.name
  end

  scenario "関連商品のひとつをクリックするとproductページに遷移する" do
    click_link product6.name
    expect(page).to have_css 'h2', text: product6.name
    within(:css, '.media-body') do
      expect(page).to have_content product6.name
      expect(page).to have_content product6.display_price.to_s
      expect(page).to have_content product6.description
    end
  end
end
