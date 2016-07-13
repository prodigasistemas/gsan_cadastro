json.empresas do
  json.array! @empresas do |empresa|
    json.extract! empresa, :id, 
                           :nome
  end
end