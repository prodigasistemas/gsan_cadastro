class CobrancaAcaoAtividadeCronograma < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cobranca.cobranca_acao_ativ_crg'
  self.primary_key = 'caac_id'

  alias_attribute "id",                               "caac_id"
  alias_attribute "dataPrevista",                     "caac_dtprevista"
  alias_attribute "realizacao",                       "caac_tmrealizacao"
  alias_attribute "cbcr_id",                          "cbcr_id"

  belongs_to :cobranca_acao_cronograma,               foreign_key: "cbcr_id"
end  
