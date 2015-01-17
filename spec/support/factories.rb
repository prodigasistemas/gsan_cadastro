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
    municipio_id 1
    codigo 66
    ativo true
  end

  factory :cep do
    id
    codigo '66093050'
    uf 'PA'
    municipio 'BELEM'
    tipo_id 1
    tipo_logradouro 'RUA'
    logradouro 'DA MATA'
  end

end
