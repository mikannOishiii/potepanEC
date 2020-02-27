require 'rails_helper'

RSpec.feature "Products", type: :feature do
  # 商品が表示される
  scenario "show a product" do
    product = FactoryBot.create(:product)
    visit potepan_product_path(product.id)

    expect(page).to have_selector 'h2', text: "#{product.name}"
    expect(page).to have_content "#{product.name}"
    expect(page).to have_content "#{product.display_price}"
    expect(page).to have_content "#{product.description}"
  end
end
