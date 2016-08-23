FactoryGirl.define do
  factory :rota do
    association :setor_comercial
    association :empresa
    codigo 52
    ativo 1

    # not-null constraints
    lttp_id 1
    ftgr_id 1
    cbgr_id 1
  end
end
