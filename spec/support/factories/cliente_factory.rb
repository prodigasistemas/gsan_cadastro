FactoryGirl.define do
  factory :cliente do
    nome 'Fulano de Tal'
    nome_fantasia_conta 2
    permite_negativacao 1
    negativacao_periodo 2
    pessoa_sexo
    ativo 1
    association :cliente_tipo, factory: [:cliente_tipo, :pessoa_fisica]
    sequence(:cpf)  { |n| "999#{rand(10)}999999#{rand(10)}" }

    trait :pessoa_fisica do
      association :cliente_tipo, factory: [:cliente_tipo, :pessoa_fisica]
      sequence(:cpf)  { |n| "999#{rand(10)}999999#{rand(10)}" }
      cnpj nil
    end

    trait :pessoa_juridica do
      association :cliente_tipo, factory: [:cliente_tipo, :pessoa_juridica]
      sequence(:cnpj) { |n| "888888#{rand(10)}888#{rand(10)}88#{rand(10)}" }
      cpf nil
    end
  end
end
