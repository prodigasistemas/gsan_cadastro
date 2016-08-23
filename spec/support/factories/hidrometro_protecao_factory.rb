FactoryGirl.define do
  factory :hidrometro_protecao do
    descricao_protecao "Sem tampa"
    abreviacao "ST"
    indicador_uso 1
    ultima_alteracao Time.zone.now
  end
end