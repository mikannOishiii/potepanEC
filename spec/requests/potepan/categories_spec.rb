require "rails_helper"

RSpec.describe "CategoriesRequests", type: :request do
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
  end

  describe "GET #show" do
    context "カテゴリページに遷移したとき" do
      before do
        get potepan_category_path(taxon1.id)
      end

      it "リクエストが成功すること" do
        expect(response.status).to eq 200
      end

      it "taxon1に紐づく商品が表示されていること" do
        expect(response.body).to include "RUBY ON RAILS TOTE"
        expect(response.body).to include "RUBY ON RAILS BAG"
        # taxon1に紐づかない商品は表示されない
        expect(response.body).not_to include "RUBY ON RAILS BASEBALL JERSEY"
      end
    end

    context "カラー[Red]を選択したとき" do
      before do
        get potepan_category_path(taxon1.id, color: "Red")
      end

      it "リクエストが成功すること" do
        expect(response.status).to eq 200
      end

      it "Redに紐づく商品が表示されていること" do
        expect(response.body).to include "RUBY ON RAILS TOTE"
        # Redに紐づかない商品は表示されない
        expect(response.body).not_to include "RUBY ON RAILS BAG"
        expect(response.body).not_to include "RUBY ON RAILS BASEBALL JERSEY"
      end
    end

    context "サイズ[Small]を選択したとき" do
      before do
        get potepan_category_path(taxon1.id, size: "Small")
      end

      it "リクエストが成功すること" do
        expect(response.status).to eq 200
      end

      it "Smallに紐づく商品が表示されていること" do
        expect(response.body).to include "RUBY ON RAILS BAG"
        # Smallに紐づかない商品は表示されない
        expect(response.body).not_to include "RUBY ON RAILS TOTE"
        expect(response.body).not_to include "RUBY ON RAILS BASEBALL JERSEY"
      end
    end
  end
end
