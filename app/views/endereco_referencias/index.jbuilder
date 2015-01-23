  json.array! @referencias do |referencia|
    json.extract! referencia, :id,
                              :descricao,
                              :descricao_abreviada,
                              :ativo,
                              :atualizado_em
  end
