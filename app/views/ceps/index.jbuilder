json.array! @ceps do |cep|
  json.extract! cep, :id, :codigo, :municipio, :uf, :ativo, :intervalo, :logradouro, :tipo_logradouro

  json.cep_tipo do
    json.extract! cep.cep_tipo, :id, :descricao
  end
end
