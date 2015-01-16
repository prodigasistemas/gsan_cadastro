json.logradouros do
  json.array! @logradouros do |logradouro|
    json.extract! logradouro, :id, :nome, :titulo_logradouro_id, :logradouro_tipo_id, :municipio_id, :ativo, :nome_popular, :atualizado_em
  end
end
