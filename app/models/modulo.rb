class Modulo < ActiveRecord::Base
  self.table_name = "seguranca.modulo"
  self.primary_key = "modu_id"

  alias_attribute "id" ,           "modu_id"
  alias_attribute "descricao",     "modu_dsmodulo"
  alias_attribute "abreviacao",    "modu_dsabreviado"
  alias_attribute "alterado_em",   "modu_tmultimaalteracao"
  alias_attribute "ordem",         "modu_nnordemmenu"
end