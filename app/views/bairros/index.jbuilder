json.bairros do
  json.array! @bairros do |bairro|
    json.extract! bairro, :id, :nome, :municipio_id, :codigo_prefeitura, :codigo, :ativo

    json.municipio(bairro.municipio, :id, :nome) if bairro.municipio
  end
end

json.page do
  json.total @total
  json.current_page @bairros.current_page
  json.total_pages @bairros.total_pages
  json.first_page @bairros.first_page?
  json.last_page @bairros.last_page?
end if @total