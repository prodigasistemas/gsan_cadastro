FactoryGirl.define do
  factory :hidrometro_marca do
    descricao_marca "Blah"
    abreviacao "BH"
    dia_revisao 5
    indicador_uso 1
    ultima_alteracao Time.zone.now
    codigo 5
    indicador_micro 10
    indicador_macro 100
  end
end