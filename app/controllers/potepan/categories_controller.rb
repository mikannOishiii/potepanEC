class Potepan::CategoriesController < ApplicationController
  # Viewで count_number_of_products を使えるようにする
  helper_method :count_number_of_products

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

  private

  def count_number_of_products(option_value)
    Spree::Product.includes(variants: :option_values).
      in_taxon(@taxon).
      where(spree_option_values: { name: option_value }).
      count
  end
end
