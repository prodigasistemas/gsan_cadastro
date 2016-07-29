class Quadra < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cadastro.quadra'
  self.primary_key = 'qdra_id'

  alias_attribute "id",                  "qdra_id"
  alias_attribute "setor_comercial_id",  "stcm_id"
  alias_attribute "numero_quadra",       "qdra_nnquadra"

  scope :setor_comercial_id, -> (id) { where setor_comercial_id: id }
end