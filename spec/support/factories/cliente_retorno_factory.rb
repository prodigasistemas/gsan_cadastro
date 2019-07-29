FactoryGirl.define do
  factory :cliente_retorno do
    nome  "Fulano"
    cpf   "1232333212"
    rg    "12212313"
    cnpj  ""
    email "email@mail.com"
    association :pessoa_sexo
    association :unidade_federacao
    association :cliente_tipo
    association :cliente
    tipo_operacao 1
  end
end