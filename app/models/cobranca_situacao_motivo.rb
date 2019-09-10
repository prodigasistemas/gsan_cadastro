class CobrancaSituacaoMotivo < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cobranca.cobranca_situacao_motivo'
  self.primary_key = 'cbsm_id'

  alias_attribute "id",               "cbsm_id"
  alias_attribute "descricao",        "cbsm_dscobrancasituacaomotivo"
  alias_attribute "indicador_uso",    "cbsm_icuso"
  alias_attribute "ultima_alteracao", "cbsm_tmultimaalteracao"

end