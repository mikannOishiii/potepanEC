require 'rails_helper'

RSpec.feature "Products", type: :feature do
  let(:product) { FactoryBot.create(:product) }

  # 商品が表示される
  scenario "動的に商品情報が表示される" do
    visit potepan_root_path
    expect(full_title("")).to eq "POTEPAN BIGBAG Store"
    visit potepan_product_path(product.id)
    expect(full_title(product.name)).to eq "#{product.name} - POTEPAN BIGBAG Store"
    expect(page).to have_content "#{product.name}"
    expect(page).to have_content "#{product.display_price}"
    expect(page).to have_content "#{product.description}"
  end
end
