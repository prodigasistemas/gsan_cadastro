json.extract! @micro_regiao, :id, :nome, :ativo, :regiao_id

json.regiao do
  json.extract! @micro_regiao.regiao, :id, :nome
end if @micro_regiao.regiao
