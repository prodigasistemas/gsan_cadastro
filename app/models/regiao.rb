class Regiao < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = 'cadastro.regiao'
  self.primary_key = 'regi_id'

  alias_attribute "id",             "regi_id"
  alias_attribute "nome",           "regi_nmregiao"
  alias_attribute "ativo",          "regi_icuso"
  alias_attribute "atualizado_em",  "regi_tmultimaalteracao"

  default_scope  -> { order(:nome) }
  scope :ativos, -> { where ativo: 1 }
  scope :nome,   -> (nome) { where("UPPER(regi_nmregiao) LIKE ?", "%#{nome.upcase}%") }
end
