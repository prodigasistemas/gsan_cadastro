FactoryGirl.define do
  factory :municipio do
    nome "LANDIA"
    codigo_ibge 1234567
    ddd 91
    regiao_desenvolvimento
    association :uf, factory: :unidade_federacao
    micro_regiao
    ativo 1
  end
end
