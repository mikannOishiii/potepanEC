class Potepan::ProductsController < ApplicationController
  MAX_RELATED_PRODUCTS = 4 # 関連商品表示数

  def show
    @product = Spree::Product.find(params[:id])
    @related_products = @product.order_filtered_related_products.take(MAX_RELATED_PRODUCTS)
  end
end
