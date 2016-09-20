class Funcionalidade < ActiveRecord::Base
  include IncrementableId
  include Filterable 
  
  self.table_name  = "seguranca.funcionalidade"
  self.primary_key = "fncd_id"

  alias_attribute "id",                          "fncd_id"
  alias_attribute "descricao",                   "fncd_dsfuncionalidade"
  alias_attribute "modulo_id",                   "modu_id"
  alias_attribute "atualizado_em",               "fncd_tmultimaalteracao"
  alias_attribute "funcionalidade_categoria_id", "fncg_id"

  belongs_to :modulo,                   foreign_key: :modu_id
  belongs_to :funcionalidade_categoria, foreign_key: :fncg_id

  has_many :grupo_funcionalidade_operacoes, foreign_key: :fncd_id

  scope :funcionalidades_grupo, -> (grupo_id) {
    joins(:grupo_funcionalidade_operacoes)
    .where(grupo_func_operacao: {grup_id: grupo_id})
    .where.not(funcionalidade_categoria_id: nil)
    .group("seguranca.funcionalidade.fncd_id")
  }
end