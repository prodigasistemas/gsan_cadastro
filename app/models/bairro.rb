class Bairro < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = "cadastro.bairro"
  self.primary_key = "bair_id"

  alias_attribute "id",                 "bair_id"
  alias_attribute "municipio_id",       "muni_id"
  alias_attribute "codigo",             "bair_cdbairro"
  alias_attribute "nome",               "bair_nmbairro"
  alias_attribute "codigo_prefeitura",  "bair_cdbairroprefeitura"
  alias_attribute "ativo",              "bair_icuso"
  alias_attribute "atualizado_em",      "bair_tmultimaalteracao"

  belongs_to :municipio, foreign_key: :muni_id
  has_many   :bairro_areas

  validates_uniqueness_of :codigo, scope: :muni_id
  validates_presence_of :municipio_id, :codigo, :nome
  validates_inclusion_of :ativo, in: [1,2]

  scope :join, -> { includes(:municipio).joins(:municipio).order(:nome) }
  scope :nome, -> (nome) { where("UPPER(bair_nmbairro) LIKE ?", "%#{nome.upcase}%") }
  scope :codigo, -> (codigo) { where codigo: codigo }
  scope :codigo_prefeitura, -> (codigo) { where codigo_prefeitura: codigo }
  scope :municipio_id, -> (id) { where municipio_id: id }

  def self.pesquisar(query = nil)
    if query
      where(query)
    else
      all
    end
  end
end
