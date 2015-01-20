json.array! @profissoes do |profissao|
  json.extract! profissao, :id, :descricao, :ativo, :codigo, :atualizado_em
end
