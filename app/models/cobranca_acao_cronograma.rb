class CobrancaAcaoCronograma < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cobranca.cobranca_acao_cronograma'
  self.primary_key = 'cbcr_id'

  alias_attribute "id",                               "cbcr_id"
  alias_attribute "cbac_id",                          "cbac_id"

  belongs_to :cobranca_acao,                          foreign_key: "cbac_id"
end  
