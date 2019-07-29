FactoryGirl.define do
  factory :abrangencia do
    association :contrato_medicao
    association :imovel
    association :ligacao_agua_situacao
    criado_em {Time.now}
    atualizado_em {Time.now}
  end
end