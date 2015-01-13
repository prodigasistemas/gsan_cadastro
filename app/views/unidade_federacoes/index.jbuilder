json.array! @unidade_federacoes do |unidade_federacao|
  json.extract! unidade_federacao, :id, :descricao, :sigla
end
