FactoryGirl.define do
  factory :hidrometro do
    numero_hidrometro 1234
    data_aquisicao Time.zone.now
    ano_fabricacao 2015
    indicador_macro 1
    ultima_revisao Time.zone.now
    data_baixa Time.zone.now
    numero_leitura_acumulada 2222
    numero_digitos_leitura 2222
    hidrometro_classe_metrlg_id 1
    hidrometro_marca 1
    hidrometro_diametro_id 1
    hidrometro_local_armaz_id 1
    hidrometro_motivo_baixa_id 1
    hidrometro_situacao_id 1
    ultima_alteracao Time.zone.now
    hidrometro_capacidade_id 1
    hidrometro_tipo_id 1
    hidrometro_relojoaria_id 1
    vazao_transicao 444
    vazao_nominal 555
    vazao_minima 222
    numero_tempo_garantia 10
    numero_nota_fiscal 4321
    hidrometro_class_pressao_id 1
    hidrometro_fat_correcao_id 1
    numero_tombamento 45
    indicador_operacional 1
  end
end