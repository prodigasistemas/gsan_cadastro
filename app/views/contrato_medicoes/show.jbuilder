json.entidade do
  json.extract! @contrato, :id,
                         :numero,
                         :vigencia_inicial,
                         :vigencia_final,
                         :data_assinatura

  json.empresa @contrato.empresa.atributos
end