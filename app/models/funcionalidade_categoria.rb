class FuncionalidadeCategoria < ActiveRecord::Base
  include IncrementableId
  include Filterable
  
  self.table_name  = "seguranca.funcionalidade_categoria"
  self.primary_key = "fncg_id"

  alias_attribute "id",             "fncg_id"
  alias_attribute "descricao",      "fncg_dsfuncionalidadecategoria"
  alias_attribute "superior",       "fncg_idsuperior"
  alias_attribute "em_uso",         "fncg_icuso"
  alias_attribute "modulo_id",      "modu_id"  
  alias_attribute "atualizado_em",  "fncg_tmultimaalteracao"  

  belongs_to :modulo, foreign_key: :modu_id

  has_many :subitens, class_name: "FuncionalidadeCategoria", foreign_key: "fncg_idsuperior"
end