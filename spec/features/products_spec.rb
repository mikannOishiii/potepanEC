require 'rails_helper'

RSpec.feature "Products", type: :feature do
  let(:product) { FactoryBot.create(:product) }

  # 商品が表示される
  scenario "show a product" do
    visit potepan_product_path(product.id)

    expect(page).to have_content "#{product.name}"
    expect(page).to have_content "#{product.display_price}"
    expect(page).to have_content "#{product.description}"
  end
end
