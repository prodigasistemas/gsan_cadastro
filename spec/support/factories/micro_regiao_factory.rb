FactoryGirl.define do
  factory :micro_regiao do
    id
    sequence(:nome) { |n| "MARAJO#{n}" }
    regiao
    ativo 1
  end
end