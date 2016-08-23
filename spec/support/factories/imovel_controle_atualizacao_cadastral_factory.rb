FactoryGirl.define do
  factory :imovel_controle_atualizacao_cadastral do
    imovel
    tempo_geracao Time.zone.now
    tempo_retorno { Time.zone.now + 1.hour }
    tempo_aprovacao { Time.zone.now + 1.day }
    situacao_atualizacao_cadastral
    imovel_retorno
    tempo_processamento Time.zone.now
  end
end