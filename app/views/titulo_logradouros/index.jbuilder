json.array! @titulo_logradouros do |tipo|
  json.extract! tipo, :id, :descricao, :descricao_abreviada, :descricao_abreviada_completa, :ativo
end