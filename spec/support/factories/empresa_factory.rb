FactoryGirl.define do
  factory :empresa do
    nome 'Nossa Empresa Ltda'
    ativo 1
    principal 1
    leitura 1
    cobranca 1
    validar_pagamento 1
  end
end
