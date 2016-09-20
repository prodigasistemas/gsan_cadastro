class UsuarioGrupoRestricao < ActiveRecord::Base
  include IncrementableId
  include Filterable
  
  self.table_name = "seguranca.usuario_grupo_restricao"
  self.primary_keys = :grup_id, :usur_id, :fncd_id, :oper_id 

  alias_attribute "grupo_id",           "grup_id"
  alias_attribute "usuario_id",         "usur_id"
  alias_attribute "funcionalidade_id",  "fncd_id"
  alias_attribute "operacao_id",        "oper_id"
  alias_attribute "alterado_em",        "ugrt_tmultimaalteracao"


  belongs_to :grupo,           foreign_key: :grup_id
  belongs_to :usuario,         foreign_key: :usur_id
  belongs_to :funcionalidade,  foreign_key: :fncd_id
  belongs_to :operacao,        foreign_key: :oper_id
end
  