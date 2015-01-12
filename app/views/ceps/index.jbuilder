json.array! @ceps do |cep|
  json.extract! cep, :id, :codigo, :municipio, :uf, :ativo, :intervalo, :logradouro, :tipo_logradouro, :bairro

  json.cep_tipo do
    json.extract! cep.cep_tipo, :id, :descricao if cep.cep_tipo
  end
end
