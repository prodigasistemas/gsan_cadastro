FactoryGirl.define do
  factory :imovel_tipo_ocupante_quantidade_retorno do
    quantidade 1
    association :imovel_tipo_ocupante
    association :imovel_retorno
    association :imovel
    ultima_alteracao Time.zone.now

    trait :criancas do
      association :imovel_tipo_ocupante, factory: [:imovel_tipo_ocupante, :criancas]
    end

    trait :alunos do
      association :imovel_tipo_ocupante, factory: [:imovel_tipo_ocupante, :alunos]
    end

    trait :adultos do
      association :imovel_tipo_ocupante, factory: [:imovel_tipo_ocupante, :adultos]
    end

    trait :idosos do
      association :imovel_tipo_ocupante, factory: [:imovel_tipo_ocupante, :idosos]
    end

    trait :empregados do
      association :imovel_tipo_ocupante, factory: [:imovel_tipo_ocupante, :empregados]
    end

    trait :caes do
      association :imovel_tipo_ocupante, factory: [:imovel_tipo_ocupante, :caes]
    end

    trait :outros do
      association :imovel_tipo_ocupante, factory: [:imovel_tipo_ocupante, :outros]
    end

    factory :tipo_ocupante_criancas_retorno, traits: [:criancas]
    factory :tipo_ocupante_adultos_retorno, traits: [:adultos]
    factory :tipo_ocupante_idosos_retorno, traits: [:idosos]
    factory :tipo_ocupante_empregados_retorno, traits: [:empregados]
    factory :tipo_ocupante_alunos_retorno, traits: [:alunos]
    factory :tipo_ocupante_caes_retorno, traits: [:caes]
    factory :tipo_ocupante_outros_retorno, traits: [:outros]
  end
end