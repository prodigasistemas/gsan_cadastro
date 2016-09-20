class Grupo < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = "seguranca.grupo"
  self.primary_key = "grup_id"

  alias_attribute "id",              "grup_id"
  alias_attribute "descricao",       "grup_dsgrupo"
  alias_attribute "abreviacao",      "grup_dsabreviado"
  alias_attribute "em_uso",          "grup_icuso"
  alias_attribute "atualizado_em",   "grup_tmultimaalteracao"

  has_many :usuario_grupos, foreign_key: :grup_id
end