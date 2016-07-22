class SetorComercial < ActiveRecord::Base
  include IncrementableId
  include API::Model
  include API::Filterable

  self.table_name  = 'cadastro.setor_comercial'
  self.primary_key = 'stcm_id'

  alias_attribute "id", "stcm_id"
  alias_attribute "nome", "stcm_nmsetorcomercial"

  belongs_to :imovel, foreign_key: "imov_id"
end