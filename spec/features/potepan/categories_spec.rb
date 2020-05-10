require 'rails_helper'

RSpec.feature "Categories", type: :feature do
  let!(:taxonomy) { create(:taxonomy, name: "Categories") }
  let!(:taxon1) { create(:taxon, taxonomy: taxonomy, name: "Bags") }
  let!(:taxon2) { create(:taxon, taxonomy: taxonomy, name: "Mugs") }
  let!(:type_color) { create(:option_type,  presentation: "Color") }
  let!(:type_size)  { create(:option_type,  presentation: "Size") }
  let!(:value_red)   { create(:option_value, name: "Red", presentation: "Red", option_type: type_color) }
  let!(:value_small) { create(:option_value, name: "Small", presentation: "S", option_type: type_size) }
  let!(:value_etc)   { create(:option_value, name: "Big") }
  let!(:variant_red)   { create(:variant, option_values: [value_red]) }
  let!(:variant_small) { create(:variant, option_values: [value_small]) }
  let!(:product1) do
    create(:product, taxons: [taxon1], name: "RUBY ON RAILS TOTE", variants: [variant_red])
  end
  let!(:product2) do
    create(:product, taxons: [taxon1], name: "RUBY ON RAILS BAG", variants: [variant_small])
  end
  let!(:other_product) { create(:product, name: "RUBY ON RAILS BASEBALL JERSEY") }
  let!(:taxonomies) { Spree::Taxonomy.all.includes(:root) }

  before do
    taxon1.move_to_child_of(taxonomy.root)
    taxon2.move_to_child_of(taxonomy.root)
    visit potepan_category_path(taxon1.id)
  end

  scenario "サイドバーにカテゴリが表示される" do
    # taxonomyが表示される
    expect(page).to have_content taxonomy.name
    # taxon1, taxon2 のカテゴリ名(と紐づく商品数)が表示される
    expect(page).to have_content "#{taxon1.name} (#{taxon1.all_products.count})"
    expect(page).to have_content "#{taxon2.name} (#{taxon2.all_products.count})"
    # colorsが表示される
    within find("a", text: "Red") do
      expect(page).to have_selector "span", text: "(1)"
    end
    # sizesが表示される
    within ".list-unstyled.clearfix" do
      within find("a", text: "S") do
        expect(page).to have_selector "span", text: "(1)"
      end
    end
  end

  scenario "カテゴリに紐づく商品一覧が表示される" do
    # taxon1に紐づくすべての商品が表示される
    expect(page).to have_content product1.name
    expect(page).to have_content product2.name
    # taxon1に紐づかない商品は表示されない
    expect(page).not_to have_content other_product.name
  end

  scenario "Redに紐づく商品一覧が表示される" do
    click_link "Red(1)"
    expect(page).to have_content product1.name
    expect(page).to have_content product1.display_price
    expect(page).not_to have_content product2.name
    expect(page).not_to have_content other_product.name
  end

  scenario "Smallに紐づく商品一覧が表示される" do
    click_link "S(1)"
    expect(page).to have_content product2.name
    expect(page).to have_content product2.display_price
    expect(page).not_to have_content product1.name
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
