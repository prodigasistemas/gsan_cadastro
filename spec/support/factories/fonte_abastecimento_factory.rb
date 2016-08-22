FactoryGirl.define do
  factory :fonte_abastecimento do
    descricao "Carro Pipa"
    abreviacao "CP"
    indicador_uso 1
    ultima_alteracao Time.zone.now
    volume_fixo 100
    permite_poco false
  end
end