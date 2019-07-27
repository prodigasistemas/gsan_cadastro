FactoryGirl.define do
  factory :logradouro_bairro do
    association :logradouro
    association :bairro
  end
end