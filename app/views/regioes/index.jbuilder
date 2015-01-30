json.regioes do
  json.array! @regioes do |regiao|
    json.extract! regiao, :id, :nome, :ativo
  end
end

json.partial! "shared/page", total: @total, models: @regioes
