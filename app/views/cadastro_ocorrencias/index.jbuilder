json.entidades do
  json.array! @cadastro_ocorrencias do |ocorrencia|
    json.id ocorrencia.id
    json.descricao ocorrencia.descricao
  end
end
