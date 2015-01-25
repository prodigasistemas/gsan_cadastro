FactoryGirl.define do
  factory :cliente_endereco do
    cliente
    endereco_tipo
    numero 12
    complemento 'perto do morro do jabuti'
    logradouro_cep
    logradouro_bairro
    correspondencia 2
    referencia
    logradouro
  end
end
