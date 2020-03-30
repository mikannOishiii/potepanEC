require 'rails_helper'

RSpec.describe Spree::Product, type: :model do
  describe "related_products" do
    let!(:taxon1) { create(:taxon) }
    let!(:taxon2) { create(:taxon) }
    let!(:product1) { create(:product, taxons: [taxon1, taxon2]) }
    let!(:product2) { create(:product, taxons: [taxon1]) }
    let!(:product3) { create(:product, taxons: [taxon1]) }
    let!(:product4) { create(:product, taxons: [taxon1]) }
    let!(:product5) { create(:product, taxons: [taxon1]) }
    let!(:product6) { create(:product, taxons: [taxon1, taxon2]) }
    let!(:other_product) { create(:product) }

    it "order_asc_related_products を正しく返す" do
      # product1と1つでもカテゴリが同じ商品をすべて取得し登録昇順で返す
      expect(product1.order_asc_related_products).to eq [product2, product3, product4, product5, product6]
      # product1と同じカテゴリではない商品は含まれない
      expect(product1.order_asc_related_products).not_to include other_product
    end

    it "order_filtered_related_products を正しく返す" do
      # product1と所属カテゴリが100%一致するproduct6を配列の最初に返す
      expect(product1.order_filtered_related_products.first).to eq product6
      # product1と1つでもカテゴリが一致した商品を返す（順序は問わない）
      expect(product1.order_filtered_related_products).to include product2, product3, product4, product5
      # product1と同じカテゴリではない商品は含まれない
      expect(product1.order_filtered_related_products).not_to include other_product
    end
  end
end
