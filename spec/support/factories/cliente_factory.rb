FactoryGirl.define do
  factory :cliente do
    nome 'Fulano de Tal'
    nome_fantasia_conta 2
    permite_negativacao 1
    negativacao_periodo 2
    ativo 1
    association :cliente_tipo, factory: [:cliente_tipo, :pessoa_fisica]
    sequence(:cpf)  { |n| "99#{rand(10)}999#{rand(10)}999#{n}" }

    trait :pessoa_fisica do
      association :cliente_tipo, factory: [:cliente_tipo, :pessoa_fisica]
      sequence(:cpf)  { |n| "99#{rand(10)}999#{rand(10)}999#{n}" }
    end

    trait :pessoa_juridica do
      association :cliente_tipo, factory: [:cliente_tipo, :pessoa_juridica]
      sequence(:cnpj) { |n| "8#{rand(10)}8888#{rand(10)}888#{rand(10)}88#{n}" }
    end
  end
end
