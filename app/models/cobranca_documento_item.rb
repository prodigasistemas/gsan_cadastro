class CobrancaDocumentoItem < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cobranca.cobranca_documento_item'
  self.primary_key = 'cdit_id'

  alias_attribute "id",                       "cdit_id"
  alias_attribute "cbdo_id",                  "cbdo_id"

  belongs_to :cobranca_documento,             foreign_key: "cbdo_id"
end  
