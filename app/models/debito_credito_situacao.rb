class DebitoCreditoSituacao < ActiveRecord::Base
  self.table_name  = 'faturamento.debito_credito_situacao'
  self.primary_key = 'dcst_id'

  alias_attribute "id",                        "dcst_id"
  alias_attribute "descricao",                 "dcst_dsdebitocreditosituacao"

  SITUACAO = {
    normal: 0,
    retificada: 1,
    incluida: 2,
    cancelada: 3,
    cancelada_por_retificacao: 4
  }
end