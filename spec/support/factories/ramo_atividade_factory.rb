FactoryGirl.define do
  factory :ramo_atividade do
    sequence(:codigo) { |n| n + 1 }
    sequence(:descricao) { |n| "Ramo de atividade #{n}" }
    ativo 1
  end
end
