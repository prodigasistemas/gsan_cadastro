class Localidade < ActiveRecord::Base
  include IncrementableId
  include API::Model
  include API::Filterable

  self.table_name  = 'cadastro.localidade'
  self.primary_key = 'loca_id'

  alias_attribute "id",     "loca_id"
  alias_attribute "nome",   "loca_nmlocalidade"

  belongs_to :imovel, foreign_key: "imov_id"

  scope :nome, -> (nome) { where("UPPER(loca_nmlocalidade) LIKE ?", "%#{nome.upcase}%") }
end