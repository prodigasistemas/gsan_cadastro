json.array! @tipos do |tipo|
  json.extract! tipo, :id, :descricao, :ativo, :atualizado_em
end
