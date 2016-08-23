class Localidade < ActiveRecord::Base
  include IncrementableId
  include API::Model
  include API::Filterable

  self.table_name  = 'cadastro.localidade'
  self.primary_key = 'loca_id'

  alias_attribute "id",     "loca_id"
  alias_attribute "nome",   "loca_nmlocalidade"
  alias_attribute "gerencia_regional_id", "greg_id"
  alias_attribute "localidade_escritorio_local", "loca_cdelo"
  alias_attribute "unidade_negocio_id", "uneg_id"

  belongs_to :imovel, foreign_key: "imov_id"
  has_one    :gerencia_regional, foreign_key: "greg_id"

  scope :nome, -> (nome) { where("UPPER(loca_nmlocalidade) LIKE ?", "%#{nome.upcase}%") }
end