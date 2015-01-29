FactoryGirl.define do
  factory :regiao do
    id
    sequence(:nome) { |n| "NORTE #{n}" }
    ativo 1
  end
end