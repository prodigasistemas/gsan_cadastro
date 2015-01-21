  json.array! @esferas do |esfera|
    json.extract! esfera, :id,
                          :descricao,
                          :ativo,
                          :permite_gerar_certidao_negativa_imovel, :permite_gerar_certidao_negativa_cliente,
                          :atualizado_em
  end
