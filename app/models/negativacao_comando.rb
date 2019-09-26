class NegativacaoComando < ActiveRecord::Base
    self.table_name  = 'cobranca.negativacao_comando'
    self.primary_key = 'ngcm_id'
  
    alias_attribute "id",                        "ngcm_id"

    alias_attribute "negt_id",                   "negt_id"

    belongs_to :negativador,           foreign_key: :negt_id
end