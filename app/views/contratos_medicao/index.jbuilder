json.contratos do
  json.array! @contratos do |contrato|
    json.extract! contrato, :id, 
                            :numero, 
                            :vigencia_inicial, 
                            :vigencia_final, 
                            :data_assinatura, 
                            :empresa_id

  end
end