class Potepan::CategoriesController < ApplicationController
  def show
    @category = Spree::Taxon.find(params[:id])
    @products = @category.all_products
  end
end
