json.bairro_areas do
  json.array! @bairro_areas do |bairro_area|
    json.extract! bairro_area, :id, :nome, :distrito_operacional_id, :bairro_id
  end
end