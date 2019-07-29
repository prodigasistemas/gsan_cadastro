FactoryGirl.define do
  factory :cliente_endereco do
    association :cliente
    association :endereco_tipo
    numero 12
    complemento 'perto do morro do jabuti'
    association :logradouro_cep
    association :logradouro_bairro
    correspondencia 2
    association :referencia
    association :logradouro
  end
end
