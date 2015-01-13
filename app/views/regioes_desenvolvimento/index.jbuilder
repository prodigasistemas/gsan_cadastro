json.array! @regioes_desenvolvimento do |regiao_desenvolvimento|
  json.extract! regiao_desenvolvimento, :id, :nome, :ativo
end
