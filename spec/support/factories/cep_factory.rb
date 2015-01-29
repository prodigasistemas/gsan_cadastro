FactoryGirl.define do
  factory :cep do
    sequence(:codigo) { |n| 66093050 + n }
    uf 'PA'
    municipio 'BELEM'
    tipo_id 1
    logradouro_tipo 'RUA'
    logradouro 'DA MATA'
    bairro 'GUAMA'
    ativo 1
  end
end
