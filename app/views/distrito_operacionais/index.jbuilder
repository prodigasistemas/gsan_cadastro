json.array! @distrito_operacionais do |distrito_operacional|
  json.extract! distrito_operacional, :id, :descricao, :abreviacao, :ativo, :sistema_abastecimento_id, :zona_abastecimento_id
end
