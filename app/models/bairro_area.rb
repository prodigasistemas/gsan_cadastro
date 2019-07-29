class BairroArea < ActiveRecord::Base
  include IncrementableId
  include Filterable

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

  validates_presence_of :nome
  validates_length_of   :nome, maximum: 40

  scope :com_dados,                      -> { includes(:distrito_operacional).eager_load(:distrito_operacional).order(:nome) }
  scope :nome,                      -> (nome) { where("UPPER(brar_nmbairroarea) LIKE ?", "%#{nome.upcase}%") }
  scope :bairro_id,                 -> (id) { where bairro_id: id }
  scope :distrito_operacional_id,   -> (id) { where distrito_operacional_id: id }
end