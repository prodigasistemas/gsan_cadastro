json.array! @ramos do |ramo|
  json.extract! ramo, :id, :codigo, :descricao, :atualizado_em, :ativo
end
