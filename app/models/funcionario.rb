class Funcionario < ActiveRecord::Base
  include IncrementableId
  include API::Model
  include API::Filterable

  self.table_name = 'cadastro.funcionario'
  self.primary_key = 'func_id'

  alias_attribute "id",               "func_id"
  alias_attribute "nome",             "func_nmfuncionario"
  alias_attribute "ultima_alteracao", "func_tmultimaalteracao"
  alias_attribute "empresa_id",       "empr_id"
  alias_attribute "unidade_id",       "unid_id"
  alias_attribute "funcao_id",        "fuca_id"
  alias_attribute "cpf",              "func_nncpf"
  alias_attribute "nascimento",       "func_dtnascimento"

  belongs_to :empresa, foreign_key: "empr_id"
end
