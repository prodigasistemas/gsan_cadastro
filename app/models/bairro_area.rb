class BairroArea < ActiveRecord::Base
  include IncrementableId

  self.table_name  = "cadastro.bairro_area"
  self.primary_key = "brar_id"

  alias_attribute "id",                       "brar_id"
  alias_attribute "bairro_id",                "bair_id"
  alias_attribute "distrito_operacional_id",  "diop_id"
  alias_attribute "nome",                     "brar_nmbairroarea"
  alias_attribute "atualizado_em",            "brar_tmultimaalteracao"
  alias_attribute "codigo_bairro_area",       "brar_cdbairroarea"
  alias_attribute "codigo_bairro_siac",       "brar_cdbairrosiac"
  alias_attribute "codigo_bairro_sci",        "brar_cdbairrosci"
  alias_attribute "codigo_bairro_municipio",  "brar_cdmunicipio"

  belongs_to :bairro, foreign_key: :bair_id
  belongs_to :distrito_operacional, foreign_key: :diop_id
end