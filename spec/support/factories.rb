FactoryGirl.define do
  sequence(:id) { |n| n }

  factory :cep_tipo do
    id
    descricao  "ÚNICO"
    ativo 1
  end

  factory :tipo_logradouro do
    id
    descricao  "RUA"
    ativo 1
  end

  factory :bairro do
    id
    nome "ALGODOAL"
    municipio
    codigo 66
    ativo 1
  end

  factory :cep do
    id
    sequence(:codigo) { |n| 66093050 + n }
    uf 'PA'
    municipio 'BELEM'
    tipo_id 1
    tipo_logradouro 'RUA'
    logradouro 'DA MATA'
    ativo 1
  end

  factory :logradouro_cep do
    logradouro
    cep
    ativo 1
  end

  factory :logradouro_bairro do
    logradouro
    bairro
  end

  factory :regiao_desenvolvimento do
    id
    nome "METROPOLITANA"
    ativo 1
  end

  factory :micro_regiao do
    id
    nome "MARAJO"
    regiao
    ativo 1
  end

  factory :regiao do
    id
    nome "NORTE"
    ativo 1
  end

  factory :unidade_federacao do
    id
    descricao "PARA"
    sigla "PA"
  end

  factory :municipio do
    nome "LANDIA"
    codigo_ibge 1234567
    ddd 91
    regiao_desenvolvimento
    association :uf, factory: :unidade_federacao
    micro_regiao
    ativo 1
  end

  factory :logradouro do
    nome "BACON"
    municipio
    ativo 1
    tipo_logradouro
  end

  factory :imovel do
    id
    localidade_id 1
    setor_comercial_id 2
    quadra_id 1
    numero_lote 1
    numero_sublote 1
    numero_imovel 1
    indicador_imovel_condominio 1
    situacao_ligacao_agua_id 1
    situacao_ligacao_esgoto_id 1
    perfil_imovel_id 1
    indicador_debito_conta 1
    tarifa_id 1
  end

end
