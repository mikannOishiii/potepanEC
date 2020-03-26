RSpec.shared_context "product setup" do
  let!(:taxon1) { create(:taxon) }
  let!(:taxon2) { create(:taxon) }
  let!(:product1) { create(:product, taxons: [taxon1, taxon2]) }
  let!(:product2) { create(:product, taxons: [taxon1]) }
  let!(:product3) { create(:product, taxons: [taxon1]) }
  let!(:product4) { create(:product, taxons: [taxon1]) }
  let!(:product5) { create(:product, taxons: [taxon1]) }
  let!(:product6) { create(:product, taxons: [taxon1, taxon2]) }
  let!(:other_product) { create(:product) }
end
