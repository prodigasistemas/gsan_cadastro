FactoryGirl.define do
  factory :cep_tipo do
    id
    sequence(:descricao) { |n| "CEP TIPO #{n}" }
    ativo 1
  end
end