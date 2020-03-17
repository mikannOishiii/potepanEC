require 'rails_helper'

RSpec.feature "Categories", type: :feature do
  include_context "category setup"

  before do
    visit potepan_category_path(taxon1.id)
  end

  # 商品が表示される
  scenario "サイドバーにカテゴリが表示される" do
    # taxonomyが表示される
    expect(page).to have_content taxonomy.name
    # taxon1, taxon2 のカテゴリ名(と紐づく商品数)が表示される
    expect(page).to have_content "#{taxon1.name} (#{taxon1.products.count})"
    expect(page).to have_content "#{taxon2.name} (#{taxon2.products.count})"
  end

  scenario "カテゴリに紐づく商品一覧が表示される" do
    # taxon1に紐づくすべての商品が表示される
    taxon1.products.each do |product|
      expect(page).to have_content product.name
    end
    # taxon1に紐づかない商品は表示されない
    expect(page).not_to have_content other_product.name
  end

  scenario "商品をクリックするとproductページに遷移する" do
    click_link product1.name
    expect(page).to have_css 'h2', text: product1.name
    within(:css, '.media-body') do
      expect(page).to have_content product1.name
      expect(page).to have_content product1.display_price.to_s
      expect(page).to have_content product1.description
    end
  end
end
