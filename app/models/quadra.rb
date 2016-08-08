class Quadra < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cadastro.quadra'
  self.primary_key = 'qdra_id'

  alias_attribute "id",                  "qdra_id"
  alias_attribute "setor_comercial_id",  "stcm_id"
  alias_attribute "numero_quadra",       "qdra_nnquadra"

  belongs_to :setor_comercial, foreign_key: :stcm_id
  belongs_to :rota,            foreign_key: :rota_id
  has_many :imoveis,           foreign_key: :qdra_id

  scope :setor_comercial_id, -> (id) { where setor_comercial_id: id }
end