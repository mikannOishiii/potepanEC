RSpec.shared_context "category setup" do
  let!(:taxonomy) { create(:taxonomy, name: "Categories") }
  let!(:taxon1) { create(:taxon, taxonomy: taxonomy, name: "Bags") }
  let!(:taxon2) { create(:taxon, taxonomy: taxonomy, name: "Mugs") }
  let!(:product1) { create(:product, taxons: [taxon1], name: "RUBY ON RAILS TOTE") }
  let!(:product2) { create(:product, taxons: [taxon1], name: "RUBY ON RAILS BAG") }
  let!(:other_product) { create(:product, name: "RUBY ON RAILS BASEBALL JERSEY") }
end
