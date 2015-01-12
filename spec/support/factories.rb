FactoryGirl.define do
  sequence(:id) { |n| n }

  factory :cep_tipo do
    id
    descricao  "ÚNICO"
    ativo true
  end

  factory :bairro do
    id
    nome "ALGODOA"
    municipio_id  1
    codigo 66
    ativo true
  end
end
