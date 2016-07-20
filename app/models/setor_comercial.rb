class SetorComercial < ActiveRecord::Base
  include IncrementableId

  self.table_name  = 'cadastro.setor_comercial'
  self.primary_key = 'stcm_id'

  alias_attribute "id", "stcm_id"

  belongs_to :imovel, foreign_key: "imov_id"
end