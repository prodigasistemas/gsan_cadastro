json.array! @ceps do |cep|
  json.extract! cep, :id, :codigo, :municipio, :bairro, :uf
end
