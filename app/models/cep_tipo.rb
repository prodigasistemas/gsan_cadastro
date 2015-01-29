class CepTipo < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = 'cadastro.cep_tipo'
  self.primary_key = 'cept_id'

  alias_attribute "id",            "cept_id"
  alias_attribute "descricao",     "cept_dsceptipo"
  alias_attribute "ativo",         "cept_icuso"
  alias_attribute "atualizado_em", "cept_tmultimaalteracao"

  validates_presence_of   :descricao
  validates_uniqueness_of :descricao
  validates_length_of     :descricao, maximum: 20

  scope :ativo, -> { where(ativo: true) }
  scope :descricao, -> (descricao) { where("UPPER(cept_dsceptipo) LIKE ?", "%#{descricao.upcase}%") }

  has_many :ceps, foreign_key: :cept_id
end
