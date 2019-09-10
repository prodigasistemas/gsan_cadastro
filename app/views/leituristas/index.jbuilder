json.entidades do
  json.array! @leituristas do |leiturista|
    json.id leiturista.id
    json.empresa_id leiturista.empresa_id
    json.nome leiturista.try(:funcionario).try(:nome)
    json.usuario_id leiturista.try(:usuario).try(:usur_id)
  end
end
