json.micro_regioes do
  json.array! @micro_regioes do |micro_regiao|
    json.extract! micro_regiao, :id, :nome, :ativo

    json.regiao do
      json.extract! micro_regiao.regiao, :id, :nome
    end if micro_regiao.regiao
  end
end

json.partial! "shared/page", total: @total, models: @micro_regioes
