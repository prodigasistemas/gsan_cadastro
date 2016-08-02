class Funcionalidade < ActiveRecord::Base
  self.table_name  = "seguranca.funcionalidade"
  self.primary_key = "fncd_id"

  alias_attribute "descricao",     "fncd_dsfuncionalidade"
  alias_attribute "modulo_id",      "modu_id"
  alias_attribute "atualizado_em",  "fncd_tmultimaalteracao"  

  belongs_to :modulo, foreign_key: :modu_id
end