FactoryGirl.define do
  factory :contrato_medicao do
    sequence(:numero) { |n| "000#{n}" }
    vigencia_inicial '2016-01-01 10:00'
    vigencia_final   '2016-01-20 16:00'
    data_assinatura  '2016-01-01'
    empresa
  end
end
