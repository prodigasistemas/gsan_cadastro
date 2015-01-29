FactoryGirl.define do
  factory :regiao_desenvolvimento do
    id
    sequence(:nome) { |n| "METROPOLITANA #{n}" }
    ativo 1
  end
end