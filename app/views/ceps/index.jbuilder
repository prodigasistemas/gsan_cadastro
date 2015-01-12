json.array! @ceps do |cep|
  json.extract! cep, :id, :codigo
end
