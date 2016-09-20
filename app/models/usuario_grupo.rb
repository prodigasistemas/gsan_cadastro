class UsuarioGrupo < ActiveRecord::Base
  
  self.table_name  = "seguranca.usuario_grupo"
  self.primary_keys = :grup_id, :usur_id

  alias_attribute :grupo_id,      :grup_id
  alias_attribute :usuario_id,    :usur_id
  alias_attribute :atualizado_em, :usgr_tmultimaalteracao
  
  belongs_to :usuario, foreign_key:  :usur_id
  belongs_to :grupo,   foreign_key:  :grup_id
end