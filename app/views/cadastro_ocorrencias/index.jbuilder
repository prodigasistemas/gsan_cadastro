json.entidades do
  json.array! @cadastro_ocorrencias do |ocorrencia|
    json.id ocorrencia.id
    json.descricao ocorrencia.descricao
    json.indicador_validacao ocorrencia.indicador_validacao
  end
end
