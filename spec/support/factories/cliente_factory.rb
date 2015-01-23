FactoryGirl.define do
  factory :cliente do
    nome 'Fulano de Tal'
    nome_fantasia_conta 2
    permite_negativacao 1
    negativacao_periodo 2
    ativo 1

    trait :pessoa_fisica do
      sequence(:cpf) { |n| "9999999999#{n}" }
    end

    trait :pessoa_juridica do
      cnpj '88888888888888'
    end
  end
end