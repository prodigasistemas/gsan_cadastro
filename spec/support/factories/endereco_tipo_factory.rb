FactoryGirl.define do
  factory :endereco_tipo do
    sequence(:descricao) { |n| "Endereco Tipo #{n}" }
    ativo 1
  end
end
