FactoryGirl.define do
  factory :ramal_local_instalacao do
    descricao "FRENTE"
    abreviado "FR"
    indicador_uso 1
    ultima_alteracao Time.zone.now
  end
end