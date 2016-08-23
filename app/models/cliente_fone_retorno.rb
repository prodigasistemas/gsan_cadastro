class ClienteFoneRetorno < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'atualizacaocadastral.cliente_fone_retorno'
  self.primary_key = 'clfr_id'

  alias_attribute "id", "clfr_id"
  alias_attribute "ddd", "clfr_cdddd"
  alias_attribute "fone", "clfr_nnfone"
  alias_attribute "ultima_alteracao", "clfr_tmultimaalteracao"
  alias_attribute "fone_tipo_id", "fnet_id"
  alias_attribute "cliente_id", "clie_id"
  alias_attribute "cliente_retorno_id", "clir_id"

  belongs_to :cliente, foreign_key: "clie_id"
  belongs_to :cliente_retorno, foreign_key: "clir_id"
  belongs_to :fone_tipo, foreign_key: "fnet_id"
end