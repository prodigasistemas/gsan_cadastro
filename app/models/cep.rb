class Cep < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = 'cadastro.cep'
  self.primary_key = 'cep_id'

  attr_accessor :municipio_model

  alias_attribute "id",               "cep_id"
  alias_attribute "codigo",           "cep_cdcep"
  alias_attribute "uf",               "cep_dsufsigla"
  alias_attribute "municipio",        "cep_nmmunicipio"
  alias_attribute "bairro",           "cep_nmbairro"
  alias_attribute "tipo_id",          "cept_id"
  alias_attribute "ativo",            "cep_icuso"
  alias_attribute "logradouro_tipo",  "cep_dslogradourotipo"
  alias_attribute "logradouro",       "cep_nmlogradouro"
  alias_attribute "atualizado_em",    "cep_tmultimaalteracao"
  alias_attribute "intervalo",        "cep_dsintervalonumeracao"

  belongs_to :cep_tipo, foreign_key: :cept_id
  has_many :logradouro_ceps, foreign_key: :cep_id, inverse_of: :cep
  has_many :logradouros, through: :logradouro_ceps

  validates_presence_of :codigo, :tipo_id, :municipio, :logradouro_tipo, :logradouro, :uf
  validates_uniqueness_of :codigo
  validates_format_of     :codigo, with: /\A\d{8}\z/
  validates_inclusion_of  :ativo, in: [1,2]
  validate                :valida_range_cep
  validates_length_of     :uf, maximum: 2
  validates_length_of     :municipio, maximum: 30
  validates_length_of     :bairro, maximum: 30
  validates_length_of     :logradouro, maximum: 50
  validates_length_of     :logradouro_tipo, maximum: 20

  scope :com_dados, -> { includes(:cep_tipo).eager_load(:cep_tipo) }
  scope :filtro_logradouro, -> (nome) { where("UPPER(cep_nmlogradouro) LIKE ?", "%#{nome.upcase}%") }
  scope :filtro_bairro, -> (nome) { where("UPPER(cep_nmbairro) LIKE ?", "%#{nome.upcase}%") }
  scope :filtro_municipio, -> (nome) { where("UPPER(cep_nmmunicipio) LIKE ?", "%#{nome.upcase}%") }
  scope :tipo_id, -> (id) { where tipo_id: id }
  scope :uf, -> (uf) { where uf: uf }
  scope :logradouro_tipo, -> (tipo) { where logradouro_tipo: tipo }
  scope :codigo, -> (codigo) { where codigo: codigo }

private

  def valida_range_cep
    errors.add(:codigo, :range) if municipio_model.present? && valida_ceps_municipio
  end

  def valida_ceps_municipio
    return false unless municipio_possui_range_de_ceps?
    return !codigo_pertence_ao_range?
  end

  def municipio_possui_range_de_ceps?
    municipio_model.cep_inicial.present? && municipio_model.cep_final.present?
  end

  def codigo_pertence_ao_range?
    codigo.between?(municipio_model.cep_inicial, municipio_model.cep_final)
  end
end
