FactoryGirl.define do
  factory :logradouro_titulo do
    id
    sequence(:descricao) { |n| "Logradouro Titulo #{n}" }
    sequence(:descricao_abreviada) { |n| "A#{n}" }
    sequence(:descricao_abreviada_completa) { |n| "Completa#{n}" }
    ativo 1
  end
end
