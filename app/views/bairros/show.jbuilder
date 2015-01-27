json.extract! @bairro, :id, :codigo, :nome, :ativo, :codigo_prefeitura, :municipio_id

json.municipio do
  json.extract! @bairro.municipio, :id, :nome
  json.uf @bairro.municipio.uf, :id, :sigla, :descricao
end if @bairro.municipio

json.bairro_areas do
  json.array! @bairro.bairro_areas do |bairro_area|
    json.extract! bairro_area, :id, :nome, :distrito_operacional_id

    json.distrito_operacional bairro_area.distrito_operacional, :id, :descricao, :abreviacao if bairro_area.distrito_operacional
  end
end