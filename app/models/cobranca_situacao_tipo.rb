class CobrancaSituacaoTipo < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cobranca.cobranca_situacao_tipo'
  self.primary_key = 'cbsp_id'

  alias_attribute "id",               "cbsp_id"
  alias_attribute "descricao",        "cbsp_dscobrancasituacaotipo"
  alias_attribute "indicador_uso",    "cbsp_icuso"
  alias_attribute "ultima_alteracao", "cbsp_tmultimaalteracao"
  alias_attribute "informa_data",     "cbsp_icinformadata"
  alias_attribute "emite_cobranca",   "cbsp_icemitedoccobranca"

end