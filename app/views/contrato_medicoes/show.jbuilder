json.entidade do
  json.id @contrato.id 
  json.numero @contrato.numero
  json.vigencia_inicial @contrato.vigencia_inicial
  json.vigencia_final @contrato.vigencia_final
  json.data_assinatura @contrato.data_assinatura
  json.empresa_id @contrato.empresa_id
  json.empresa @contrato.atributos["empresa"]

  json.imoveis @contrato.imoveis.map {|imovel| imovel.atributos([:localidade, :setor_comercial])}

end