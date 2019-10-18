class ContaMotivoRevisao < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'faturamento.conta_motivo_revisao'
  self.primary_key = 'cmrv_id'

  alias_attribute "id",                "cmrv_id"
  alias_attribute "descricao",         "cmrv_dsmotivorevisaoconta"
  alias_attribute "indicador_uso",     "cmrv_icuso"
  alias_attribute "ultima_alteracao",  "cmrv_tmultimaalteracao"
end