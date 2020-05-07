module Potepan::ProductDecorator
  def self.prepended(base)
    base.scope :new_available, -> { base.order(available_on: :desc) }
  end

  def order_filtered_related_products
    # shuffle: 同じ商品ばかり並ばないように配列をshuffle
    # partition: 所属カテゴリが100%マッチするものは配列の先頭に移動
    order_asc_related_products.shuffle.partition { |taxon_product| taxon_product.taxon_ids == taxon_ids }.flatten
  end

  def order_asc_related_products
    Spree::Product.includes(master: [:images, :default_price]).in_taxons(taxons).distinct.where.not(id: id)
  end

  Spree::Product.prepend self
end
