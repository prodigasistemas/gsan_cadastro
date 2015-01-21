json.array! @cliente_tipos do |tipo|
  json.extract! tipo, :id, :descricao, :pessoa_fisica_juridica, :ativo, :atualizado_em, :esfera_poder_id
end
