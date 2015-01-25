FactoryGirl.define do
  factory :fone_tipo do
    sequence(:descricao) { |n| "Fone Tipo #{n}" }
    ativo 1
  end
end
