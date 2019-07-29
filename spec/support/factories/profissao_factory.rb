FactoryGirl.define do
  factory :profissao do
    sequence(:codigo)    { |n| n + 1 }
    sequence(:descricao) { |n| "Profissao #{n}" }
    ativo 1
  end
end
