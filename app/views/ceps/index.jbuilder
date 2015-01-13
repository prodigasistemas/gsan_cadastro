json.array! @ceps do |cep|
  json.extract! cep, :id, :codigo, :municipio, :uf, :ativo, :intervalo, :logradouro, :tipo_logradouro, :bairro, :tipo_id

  json.cep_tipo do
    json.extract! cep.cep_tipo, :id, :descricao
  end if cep.cep_tipo
end
