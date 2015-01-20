json.array! @orgaos do |orgao|
  json.extract! orgao, :id, :descricao, :descricao_abreviada, :ativo, :atualizado_em
end
