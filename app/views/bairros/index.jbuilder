json.array! @bairros do |bairro|
  json.extract! bairro, :id, :nome, :municipio_id, :codigo_prefeitura, :codigo
end
