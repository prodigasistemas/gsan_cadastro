json.bairro_areas do
  json.array! @bairro_areas do |bairro_area|
    json.extract! bairro_area, :id, :nome, :distrito_operacional_id, :bairro_id

    json.distrito_operacional(bairro_area.distrito_operacional, :id, :descricao, :abreviacao) if bairro_area.distrito_operacional
  end
end