FactoryGirl.define do
  factory :cliente_retorno do
    nome  "Fulano"
    cpf   "1232333212"
    rg    "12212313"
    cnpj  ""
    email "email@mail.com"
    pessoa_sexo_id 1
    unidade_federecao_id 1
    cliente_tipo_id 1
    cliente_id 1
    tipo_operacao 1
  end
end