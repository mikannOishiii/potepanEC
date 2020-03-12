require 'rails_helper'

RSpec.feature "Products", type: :feature do
  let(:product) { create(:product) }

  # 商品が表示される
  scenario "動的に商品情報が表示される" do
    visit potepan_root_path
    expect(page).to have_title full_title("")
    visit potepan_product_path(product.id)
    expect(page).to have_title full_title(product.name)
    within(:css, '.media-body') do
      expect(page).to have_content product.name
      expect(page).to have_content product.display_price.to_s
      expect(page).to have_content product.description
    end
  end
end
