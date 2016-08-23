FactoryGirl.define do
  factory :situacao_atualizacao_cadastral do
    descricao "TRANSMITIDO"
    indicador_uso 1
    ultima_alteracao Time.zone.now
  end
end