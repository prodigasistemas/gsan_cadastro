class GrupoFuncionalidadeOperacao < ActiveRecord::Base
  self.table_name   = "seguranca.grupo_func_operacao"
  self.primary_keys = :grup_id, :fncd_id, :oper_id

  alias_attribute "alterado_em", "gfop_tmultimaalteracao"

  belongs_to :grupo,          foreign_key: :grup_id
  belongs_to :funcionalidade, foreign_key: :fncd_id
  belongs_to :operacao,       foreign_key: :oper_id
end