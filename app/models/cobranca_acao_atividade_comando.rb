class CobrancaAcaoAtividadeComando < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cobranca.cobranca_acao_ativ_cmd'
  self.primary_key = 'cacm_id'

  alias_attribute "id",                               "cacm_id"
  alias_attribute "cbac_id",                          "cbac_id"

  belongs_to :cobranca_acao,                          foreign_key: "cbac_id"
end  
