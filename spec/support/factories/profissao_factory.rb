FactoryGirl.define do
  factory :profissao do
    sequence(:codigo)    { |n| 1 + n }
    sequence(:descricao) { |n| "Profissao #{n}" }
    ativo 1
  end
end
