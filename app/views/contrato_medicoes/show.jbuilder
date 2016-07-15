json.entidade do
  json.extract! @contrato, :id, 
                         :numero, 
                         :vigencia_inicial,
                         :vigencia_final,
                         :data_assinatura,
                         :empresa
end