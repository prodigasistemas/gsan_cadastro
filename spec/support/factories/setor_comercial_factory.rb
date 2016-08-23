FactoryGirl.define do
  factory :setor_comercial do
    nome "Setor 50"
    codigo "S50"
    indicador_uso 1
    municipio
    ultima_alteracao Time.zone.now
    indicador_alternativo 1
    indicador_bloqueio 0
    localidade
  end
end
