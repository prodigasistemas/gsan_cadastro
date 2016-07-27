class SetorComercial < ActiveRecord::Base
  include IncrementableId
  include API::Model
  include API::Filterable

  self.table_name  = 'cadastro.setor_comercial'
  self.primary_key = 'stcm_id'

  alias_attribute "id", "stcm_id"
  alias_attribute "nome", "stcm_nmsetorcomercial"

  has_many :imoveis, foreign_key: :stcm_id
  has_many :rotas,   foreign_key: :stcm_id
end