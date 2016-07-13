class Empresa < ActiveRecord::Base
  include IncrementableId
  self.table_name  = 'cadastro.empresa'
  self.primary_key = 'empr_id'

  alias_attribute "id",          "empr_id"
  alias_attribute "nome",        "empr_nmempresa"
end