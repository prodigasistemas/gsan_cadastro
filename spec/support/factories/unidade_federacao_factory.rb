require "#{Rails.root}/spec/support/custom_sequence"

FactoryGirl.define do
  factory :unidade_federacao do
    id
    sequence(:descricao) { |n| "PARA#{n}" }
    sigla { ('A'..'Z').to_a.sample(2).join }
  end
end