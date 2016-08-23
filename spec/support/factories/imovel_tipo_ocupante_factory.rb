FactoryGirl.define do
  factory :imovel_tipo_ocupante do
    descricao "Crianças"
    indicador_uso 1
    ultima_alteracao Time.zone.now

    trait :criancas do
      before(:create) do |tipo_ocupante|
        tipo_ocupante.descricao = "Crianças"
      end
    end

    trait :adultos do
      before(:create) do |tipo_ocupante|
        tipo_ocupante.descricao = "Adultos"
      end
    end

    trait :idosos do
      before(:create) do |tipo_ocupante|
        tipo_ocupante.descricao = "Idosos"
      end
    end

    trait :empregados do
      before(:create) do |tipo_ocupante|
        tipo_ocupante.descricao = "Empregados"
      end
    end

    trait :caes do
      before(:create) do |tipo_ocupante|
        tipo_ocupante.descricao = "Cães"
      end
    end

    trait :alunos do
      before(:create) do |tipo_ocupante|
        tipo_ocupante.descricao = "Alunos"
      end
    end

    trait :outros do
      before(:create) do |tipo_ocupante|
        tipo_ocupante.descricao = "Outros"
      end
    end

    factory :tipo_ocupante_criancas, traits: [:criancas]
    factory :tipo_ocupante_adultos, traits: [:adultos]
    factory :tipo_ocupante_empregados, traits: [:empregados]
    factory :tipo_ocupante_caes, traits: [:caes]
    factory :tipo_ocupante_alunos, traits: [:alunos]
    factory :tipo_ocupante_outros, traits: [:outros]
  end
end