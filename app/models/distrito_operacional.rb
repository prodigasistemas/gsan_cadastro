class DistritoOperacional < ActiveRecord::Base
  include IncrementableId

  self.table_name  = "operacional.distrito_operacional"
  self.primary_key = "diop_id"

  alias_attribute "id",                        "diop_id"
  alias_attribute "sistema_abastecimento_id",  "stab_id"
  alias_attribute "descricao",                 "diop_dsdistritooperacional"
  alias_attribute "abreviacao",                "diop_dsabreviado"
  alias_attribute "ativo",                     "diop_icuso"
  alias_attribute "zona_abastecimento_id",     "zabs_id"
  alias_attribute "atualizado_em",             "diop_tmultimaalteracao"

  has_many :bairro_areas

  validates_length_of :descricao, maximum: 30
end