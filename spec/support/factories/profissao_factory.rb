FactoryGirl.define do
  factory :profissao do
    sequence(:codigo) { |n| 1 + n }
    descricao 'Profissa'
    ativo 1
  end
end
