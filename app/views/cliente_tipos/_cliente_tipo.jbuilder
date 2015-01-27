json.extract! cliente_tipo, :id, :descricao, :pessoa_fisica_juridica, :ativo, :atualizado_em, :esfera_poder_id

json.esfera_poder do
  json.partial! "esferas_poder/esfera_poder", esfera_poder: cliente_tipo.esfera_poder
end if cliente_tipo.esfera_poder


json.pessoa_tipo cliente_tipo.pessoa_tipo
