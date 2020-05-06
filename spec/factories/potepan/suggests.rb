FactoryBot.define do
  factory :potepan_suggest, class: 'Potepan::Suggest' do
    sequence(:keyword) { |n| "rails#{n}" }
  end
end
