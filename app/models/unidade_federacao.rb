class UnidadeFederacao < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = 'cadastro.unidade_federacao'
  self.primary_key = 'unfe_id'

  alias_attribute "id",            "unfe_id"
  alias_attribute "descricao",     "unfe_dsuf"
  alias_attribute "sigla",         "unfe_dsufsigla"
  alias_attribute "atualizado_em", "unfe_tmultimaalteracao"

  validates_presence_of   :descricao, :sigla
  validates_uniqueness_of :descricao, :sigla
  validates_length_of :descricao, maximum: 35
  validates_length_of :sigla, maximum: 2

  default_scope     -> { order(:descricao) }
  scope :descricao, -> (descricao) { where("UPPER(unfe_dsuf) LIKE ?", "%#{descricao.upcase}%") }
  scope :sigla,     -> (sigla) { where(sigla: sigla) }
end
