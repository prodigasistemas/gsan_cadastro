class Banco < ActiveRecord::Base
    self.table_name  = 'arrecadacao.banco'
    self.primary_key = 'bnco_id'
  
    alias_attribute "id",                 "bnco_id"
    alias_attribute "descricaoAbreviada", "bnco_nmabreviado"    
end
