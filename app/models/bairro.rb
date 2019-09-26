class Bairro < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = "cadastro.bairro"
  self.primary_key = "bair_id"

  alias_attribute "id",                 "bair_id"
  alias_attribute "municipio_id",       "muni_id"
  alias_attribute "codigo",             "bair_cdbairro"
  alias_attribute "nome",               "bair_nmbairro"
  alias_attribute "codigo_prefeitura",  "bair_cdbairroprefeitura"
  alias_attribute "ativo",              "bair_icuso"
  alias_attribute "atualizado_em",      "bair_tmultimaalteracao"

  belongs_to :municipio,    foreign_key: :muni_id
  has_many   :bairro_areas, foreign_key: :bair_id

  accepts_nested_attributes_for :bairro_areas, allow_destroy: true

  validates_uniqueness_of :codigo, scope: :muni_id
  validates_presence_of   :municipio_id, :codigo, :nome
  validates_inclusion_of  :ativo, in: [1, 2]
  validates_length_of     :nome, maximum: 30

  scope :com_dados,              -> {
    includes(:municipio, municipio: :uf).
    joins(:municipio, municipio: :uf).
    eager_load(:bairro_areas, bairro_areas: :distrito_operacional).
    order(:nome)
  }
  scope :nome,              -> (nome) { where("UPPER(bair_nmbairro) LIKE ?", "%#{nome.upcase}%") }
  scope :codigo,            -> (codigo) { where codigo: codigo }
  scope :codigo_prefeitura, -> (codigo) { where codigo_prefeitura: codigo }
  scope :municipio_id,      -> (id) { where municipio_id: id }

  def self.pesquisar(query = nil)
    if query
      where(query).order(nome: :asc)
    else
      all.order(nome: :asc)
    end
  end

  def atributos(params = [], referer = nil)
    super(params.concat([:municipio]), referer)
  end
end
