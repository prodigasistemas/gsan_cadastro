class Agencia < ActiveRecord::Base
    self.table_name  = 'arrecadacao.agencia'
    self.primary_key = 'agen_id'
  
    alias_attribute "id",          "agen_id"
    alias_attribute "codigo",      "agen_cdagencia"
    alias_attribute "bnco_id",     "bnco_id"
    
    belongs_to :banco, foreign_key:  :bnco_id
end
