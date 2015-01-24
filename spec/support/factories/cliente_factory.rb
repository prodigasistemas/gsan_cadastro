FactoryGirl.define do
  factory :cliente do
    nome 'Fulano de Tal'
    nome_fantasia_conta 2
    permite_negativacao 1
    negativacao_periodo 2
    ativo 1

    trait :pessoa_fisica do
      sequence(:cpf)  { |n| "99#{n}999#{n}999#{n}" }
    end

    trait :pessoa_juridica do
      sequence(:cnpj) { |n| "8#{n}8888#{n}888#{n}88#{n}" }
    end
  end
end
