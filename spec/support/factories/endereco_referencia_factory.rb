FactoryGirl.define do
  factory :endereco_referencia, aliases: [:referencia] do
    sequence(:descricao)            { |n| "End Referencia #{n}" }
    sequence(:descricao_abreviada)  { |n| "Desc Abreviada #{n}" }
    ativo 1
  end
end
