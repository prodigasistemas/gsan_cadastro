class Regiao < ActiveRecord::Base
  include IncrementableId

  self.table_name  = 'cadastro.regiao'
  self.primary_key = 'regi_id'

  alias_attribute "id",             "regi_id"
  alias_attribute "nome",           "regi_nmregiao"
  alias_attribute "ativo",          "mreg_icuso"
  alias_attribute "atualizado_em",  "mreg_tmultimaalteracao"
end
