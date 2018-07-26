json.entidades do
  json.array! @leituristas do |leiturista|
    json.id leiturista.id
    json.empresa_id leiturista.empresa_id
    json.nome leiturista.try(:funcionario).try(:nome)
  end
end
