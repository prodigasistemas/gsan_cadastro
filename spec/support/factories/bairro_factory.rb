FactoryGirl.define do
  factory :bairro do
    id
    nome "ALGODOAL"
    municipio
    sequence(:codigo) { |n| 1 + n }
    ativo 1
  end
end
