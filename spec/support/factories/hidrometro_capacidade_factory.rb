FactoryGirl.define do
  factory :hidrometro_capacidade do
    descricao_capacidade "50 m2/h"
    abreviacao "50"
    leitura_minima 10
    leitura_maxima 100
    indicador_uso 1
    ultima_alteracao Time.zone.now
    ordem 1
    codigo_capacidade 1
  end
end