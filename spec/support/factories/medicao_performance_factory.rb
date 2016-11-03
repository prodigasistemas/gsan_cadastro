FactoryGirl.define do 
  factory :medicao_performance do
    contrato_medicao
    imovel
    criado_em {Time.now}
    ano_mes_referencia             201601
    diferenca_consumo_agua         20
    valor_diferenca_consumo_agua   15.00
    valor_diferenca_consumo_esgoto 15.00
    percentual_consumo_esgoto      4.00
    debito_credito_situacao_id     1
  end
end