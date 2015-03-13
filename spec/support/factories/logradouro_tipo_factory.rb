require "#{Rails.root}/spec/support/custom_sequence"

FactoryGirl.define do
  factory :logradouro_tipo do
    id
    sequence(:descricao) { |n| "Logradouro Tipo #{n}" }
    sequence(:descricao_abreviada, FGCustomSequence.new(89)) { |n| "A#{n}" }
    sequence(:descricao_abreviada_completa) { |n| "Completa#{n}" }
    ativo 1
  end
end
