json.pessoa_sexos do
  json.array! @sexos do |sexo|
    json.extract! sexo, :id, :descricao, :atualizado_em, :ativo
  end
end
