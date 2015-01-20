json.array! @cliente_tipos do |tipo|
  json.extract! tipo, :id, :descricao, :pessoa_fisica_juridica, :ativo, :atualizado_em, :espera_poder_id
end
