FactoryGirl.define do
  factory :municipio do
    nome "LANDIA"
    codigo_ibge 1234567
    ddd 91
    association :regiao_desenvolvimento
    association :uf, factory: :unidade_federacao
    association :micro_regiao
    ativo 1
  end
end
