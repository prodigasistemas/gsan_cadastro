class Negativador < ActiveRecord::Base
    self.table_name  = 'cobranca.negativador'
    self.primary_key = 'negt_id'
  
    alias_attribute "id",                        "negt_id"
    alias_attribute "clie_id",                   "clie_id"

    belongs_to :cliente,           foreign_key: :clie_id
end