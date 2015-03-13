require "#{Rails.root}/spec/support/custom_sequence"

FactoryGirl.define do
  arr = ('A'..'Z').to_a

  factory :unidade_federacao do
    id
    sequence(:descricao) { |n| "PARA#{n}" }
    sequence(:sigla, FGCustomSequence.new(89)) { |n| "#{n}" }
  end
end