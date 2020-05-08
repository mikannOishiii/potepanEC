class Potepan::StaticPagesController < ApplicationController
  MAX_FEATURED_PRODUCTS = 8 # 新着商品表示数

  def home
    @new_products = Spree::Product.includes(master: [:default_price, :images]).
      new_available.take(MAX_FEATURED_PRODUCTS)
  end
end
