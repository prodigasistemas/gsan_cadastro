json.extract! @bairro, :id, :codigo, :nome, :ativo, :codigo_prefeitura, :municipio_id

json.municipio do
  json.extract! @bairro.municipio, :id, :nome
  json.uf @bairro.municipio.uf, :id, :sigla, :descricao
end if @bairro.municipio