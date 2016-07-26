FactoryGirl.define do
  factory :coeficiente do
    association :contrato_medicao
    association :ligacao_agua_situacao
    coeficiente { 0.2 }
  end
end
