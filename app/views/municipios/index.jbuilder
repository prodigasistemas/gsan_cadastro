json.array! @municipios do |municipio|
  json.extract! municipio, :id, :nome, :ativo, :atualizado_em
end
