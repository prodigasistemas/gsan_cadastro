FactoryGirl.define do
  factory :contrato_medicao do
    numero           '20160101'
    vigencia_inicial '2016-01-01 10:00'
    vigencia_final   '2016-01-20 16:00'
    data_assinatura  '2016-01-01'
    association :empresa, factory: :empresa
  end
end
