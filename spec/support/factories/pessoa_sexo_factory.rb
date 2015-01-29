FactoryGirl.define do
  factory :pessoa_sexo do
    sequence(:descricao) { |n| "SEXO #{n}" }
    ativo 1
  end
end
