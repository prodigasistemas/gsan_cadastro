FactoryGirl.define do
  factory :rota do
    association :setor_comercial
    association :empresa
    grupo_faturamento_id 1
    codigo 52
    ativo 1

    # not-null constraints
    lttp_id 1
    cbgr_id 1
  end
end
