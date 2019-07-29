FactoryGirl.define do
  factory :logradouro do
    nome "PECADO"
    association :municipio
    association :logradouro_tipo
    association :logradouro_titulo
    ativo 1
  end
end
