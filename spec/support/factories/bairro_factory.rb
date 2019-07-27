FactoryGirl.define do
  factory :bairro do
    id
    nome "ALGODOAL"
    association :municipio
    sequence(:codigo) { |n| 1 + n }
    ativo 1
  end
end
