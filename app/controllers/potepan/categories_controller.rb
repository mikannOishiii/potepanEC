class Potepan::CategoriesController < ApplicationController
  def show
    color = params[:color]
    size = params[:size]
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomys = Spree::Taxonomy.all.includes(:root)
    @colors = Spree::OptionType.find_by(presentation: "Color").option_values
    @sizes = Spree::OptionType.find_by(presentation: "Size").option_values
    if color
      @products = @taxon.all_products.filter_by_color(color)
    elsif size
      @products = @taxon.all_products.filter_by_size(size)
    else
      @products = @taxon.all_products.includes(master: [:images, :default_price])
    end
  end
end
