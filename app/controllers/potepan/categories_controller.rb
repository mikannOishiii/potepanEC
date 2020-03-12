class Potepan::CategoriesController < ApplicationController
  def show
    @category = Spree::Taxon.find(params[:id])
  end
end
