json.array! @cep_tipos do |cep_tipo|
  json.extract! cep_tipo, :id, :descricao, :ativo, :atualizado_em
end
