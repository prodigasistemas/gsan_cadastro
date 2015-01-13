json.array! @micro_regioes do |micro_regiao|
  json.extract! micro_regiao, :id, :nome, :ativo, :regiao_id
end
