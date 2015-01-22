json.array! @regioes do |regiao|
  json.extract! regiao, :id, :nome, :ativo
end
