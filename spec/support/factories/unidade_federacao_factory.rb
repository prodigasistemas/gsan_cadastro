FactoryGirl.define do
  arr = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' ]

  factory :unidade_federacao do
    id
    sequence(:descricao) { |n| "PARA#{n}" }
    sequence(:sigla) { |n| "#{arr.sample}#{arr.sample}" }
  end
end