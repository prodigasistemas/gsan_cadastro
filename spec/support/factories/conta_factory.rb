FactoryGirl.define do
  factory :conta do
    imovel
    ligacao_agua_situacao_id 1
    data_vencimento_original "2016-01-01"
    debito_credito_situacao_id_atual 1
    data_ultima_alteracao "2016-01-01"
    consumo_tarifa_id 1
    ano_mes_referencia_contabil 1
    data_vencimento "2016-01-01"
    percentual_esgoto 1
    valor_creditos 1
    valor_debitos 1
    valor_esgoto 1
    valor_agua 1
    indicador_cobranca_multa 1
    digito_verificador 1
    quadra_id 1
    localidade_id 1
    ligacao_esgoto_situacao 1
  end
end