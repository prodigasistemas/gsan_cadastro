json.entidades do
  json.array! @contratos do |contrato|
    json.extract! contrato, :id,
                            :numero,
                            :vigencia_inicial,
                            :vigencia_final,
                            :data_assinatura,
                            :empresa_id

    json.empresa contrato.empresa.atributos
  end
end