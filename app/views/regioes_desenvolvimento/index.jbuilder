json.regioes_desenvolvimento do
  json.array! @regioes_desenvolvimento do |regiao_desenvolvimento|
    json.extract! regiao_desenvolvimento, :id, :nome, :ativo
  end
end

json.partial! "shared/page", total: @total, models: @regioes_desenvolvimento
