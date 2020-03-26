require 'rails_helper'

RSpec.describe Spree::Product, type: :model do
  describe "related_products" do
    include_context "product setup"

    it "order_asc_related_products メソッドを正しく返す" do
      expect(product1.order_asc_related_products).to include product2, product3, product4, product5, product6
      expect(product1.order_asc_related_products).not_to include other_product
    end

    it "order_filtered_related_products メソッドを正しく返す" do
      expect(product1.order_filtered_related_products.first).to eq product6
      expect(product1.order_filtered_related_products).to include product2, product3, product4, product5
      expect(product1.order_filtered_related_products).not_to include other_product
    end
  end
end
