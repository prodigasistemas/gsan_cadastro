class Contrato < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cadastro.contrato'
  self.primary_key = 'cntt_id'

  alias_attribute "id",                   "cntt_id"
  alias_attribute "data_inicio",          "cntt_dtcontratoinicio"
  alias_attribute "data_fim",             "cntt_dtcontratofim"
  alias_attribute "numero_contrato",      "cntt_nncontrato"
  alias_attribute "ultima_alteracao",     "cntt_tmultimaalteracao"
  alias_attribute "data_encerramento",    "cntt_dtcontratoencerramento"
  alias_attribute "motivo_cancelamento",  "ctcn_id"
  alias_attribute "tipo_contrato",        "cttp_id"
  alias_attribute "imovel",               "imov_id"
end
