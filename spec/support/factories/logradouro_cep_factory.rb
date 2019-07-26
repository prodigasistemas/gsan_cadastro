FactoryGirl.define do
  factory :logradouro_cep do
    association :logradouro
    association :cep
    ativo 1
  end
end