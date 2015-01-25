FactoryGirl.define do
  factory :cliente_endereco do
    numero 12
    complemento 'perto do morro do jabuti'
    logradouro_cep
    logradouro_bairro
    endereco_tipo
  end
end