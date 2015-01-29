FactoryGirl.define do
  factory :orgao_expedidor_rg do
    id
    sequence(:descricao)            { |n| "Orgao Expedidor RG #{n}" }
    sequence(:descricao_abreviada)  { |n| "Abr#{n}" }
    ativo 1
  end
end
