FactoryGirl.define do
  factory :imovel_controle_atualizacao_cadastral do
    association :imovel
    tempo_geracao Time.zone.now
    tempo_retorno { Time.zone.now + 1.hour }
    tempo_aprovacao { Time.zone.now + 1.day }
    association :situacao_atualizacao_cadastral
    association :imovel_retorno
    tempo_processamento Time.zone.now
  end
end