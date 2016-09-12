class UsuarioGrupo < ActiveRecord::Base
  include API::Filterable
  include API::Model

  self.table_name  = 'seguranca.usuario_grupo'

  alias_attribute :grupo_id,   :grup_id
  alias_attribute :usuario_id, :usur_id

  belongs_to :usuario, foreign_key: :usur_id
  belongs_to :grupo,   foreign_key: :grup_id
end