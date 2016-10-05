FactoryGirl.define do
  factory :imovel do
    localidade_id 1
    setor_comercial_id 2
    quadra_id 1
    numero_lote 1
    numero_sublote 1
    numero_imovel 1
    indicador_imovel_condominio 1
    situacao_ligacao_agua_id 1
    situacao_ligacao_esgoto_id 1
    perfil_imovel_id 1
    indicador_debito_conta 1
    tarifa_id 1
    atualizado_em Time.zone.now
    percentual_abastecimento 25
  end
end