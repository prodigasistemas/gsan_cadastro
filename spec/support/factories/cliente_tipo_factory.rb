FactoryGirl.define do
  factory :cliente_tipo do
    ativo 1
    esfera_poder
    sequence(:descricao) { |n| "PESSOA FISICA #{n}" }
    pessoa_fisica_juridica 1

    trait :pessoa_fisica do
      pessoa_fisica_juridica 1
    end

    trait :pessoa_juridica do
      sequence(:descricao) { |n| "PESSOA JURIDICA #{n}" }
      pessoa_fisica_juridica 2
    end
  end
end
