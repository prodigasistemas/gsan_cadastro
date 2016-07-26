FactoryGirl.define do
  factory :abrangencia do
    contrato_medicao
    imovel
    criado_em {Time.now}
    atualizado_em {Time.now}
  end
end