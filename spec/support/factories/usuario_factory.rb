FactoryGirl.define do
  factory :usuario do
    id
    nome "User"

    # para evitar: violates not-null constraint
    utip_id 1
    usst_id 1
    usab_id 1
    empr_id 1
    usur_ictiporelatoriopadrao 2
    usur_icexibemensagem 2
  end
end
