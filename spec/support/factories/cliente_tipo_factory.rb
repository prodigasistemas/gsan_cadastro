FactoryGirl.define do
  factory :cliente_tipo do
    ativo 1
    esfera_poder
    descricao 'Pessoa física'
    pessoa_fisica_juridica 1

    trait :pessoa_fisica do
      descricao 'pessoa física'
      pessoa_fisica_juridica 1
    end

    trait :pessoa_juridica do
      descricao 'pessoa jurídica'
      pessoa_fisica_juridica 2
    end
  end
end
