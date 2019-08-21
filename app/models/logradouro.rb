class Logradouro < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cadastro.logradouro'
  self.primary_key = 'logr_id'

  alias_attribute "id",                   "logr_id"
  alias_attribute "nome",                 "logr_nmlogradouro"
  alias_attribute "logradouro_titulo_id", "lgtt_id"
  alias_attribute "logradouro_tipo_id",   "lgtp_id"
  alias_attribute "municipio_id",         "muni_id"
  alias_attribute "ativo",                "logr_icuso"
  alias_attribute "atualizado_em",        "logr_tmultimaalteracao"
  alias_attribute "nome_popular",         "logr_nmpopular"

  has_many    :logradouro_ceps,     foreign_key: "logr_id",     inverse_of: :logradouro
  has_many    :ceps,                through: :logradouro_ceps
  has_many    :logradouro_bairros,  foreign_key: "logr_id",     inverse_of: :logradouro
  has_many    :bairros,             through: :logradouro_bairros
  belongs_to  :logradouro_titulo,   foreign_key: "lgtt_id"
  belongs_to  :logradouro_tipo,     foreign_key: "lgtp_id"
  belongs_to  :municipio,           foreign_key: "muni_id"

  accepts_nested_attributes_for :logradouro_ceps, allow_destroy: true
  accepts_nested_attributes_for :logradouro_bairros, allow_destroy: true

  scope :com_dados,                  -> {
    includes(
      :municipio, { municipio: :uf },
      :logradouro_titulo,
      :logradouro_tipo,
      :logradouro_ceps, { logradouro_ceps: :cep },
      :logradouro_bairros, { logradouro_bairros: :bairro },
    ).
    joins(
      :municipio, { municipio: :uf }
    ).
    eager_load(
      :municipio,
      :logradouro_titulo,
      :logradouro_tipo,
      :logradouro_ceps, { logradouro_ceps: :cep },
      :logradouro_bairros, { logradouro_bairros: :bairro },
    ).
    order(:nome)
  }
  scope :nome,                  -> (nome) { where("UPPER(logr_nmlogradouro) LIKE ?", "%#{nome.upcase}%") }
  scope :nome_popular,          -> (nome) { where("UPPER(logr_nmpopular) LIKE ?", "%#{nome.upcase}%") }
  scope :municipio_id,          -> (id) { where municipio_id: id }
  scope :logradouro_titulo_id,  -> (id) { where lgtt_id: id }
  scope :logradouro_tipo_id,    -> (id) { where lgtp_id: id }

  validates_presence_of :nome, :municipio_id, :logradouro_tipo_id
  validate :validar_destrucao_logradouro_cep
  validate :validar_destrucao_logradouro_bairro
  validates_inclusion_of :ativo, in: [1, 2]
  validates_length_of :nome, maximum: 40
  validates_length_of :nome_popular, maximum: 30

  def self.filter_data(termos, incluir = [])
    select(campos_busca)
    .joins(municipio: :uf, logradouro_ceps: :cep, logradouro_bairros: :bairro)
    .where(condicoes_busca, termo: termos.split(" ").map{|termo| "%#{termo}%"}.join)
    .order(ordem_busca)
  end

  def atributos(params=[], referer=nil)
    self.as_json
  end

private

  def validar_destrucao_logradouro_cep
    logradouro_ceps.each do |logradouro_cep|
      if logradouro_cep.marked_for_destruction?
        errors.add(:base, :imoveis_are_present_in_cep,          cep: logradouro_cep.cep.codigo) if logradouro_cep.imoveis.any?
        errors.add(:base, :cliente_endereco_are_present_in_cep, cep: logradouro_cep.cep.codigo) if logradouro_cep.cliente_enderecos.any?
      end
    end
  end

  def validar_destrucao_logradouro_bairro
    logradouro_bairros.each do |logradouro_bairro|
      if logradouro_bairro.marked_for_destruction?
        errors.add(:base, :imoveis_are_present_in_bairro,           bairro: logradouro_bairro.bairro.nome) if logradouro_bairro.imoveis.any?
        errors.add(:base, :cliente_endereco_are_present_in_bairro,  bairro: logradouro_bairro.bairro.nome) if logradouro_bairro.cliente_enderecos.any?
      end
    end
  end

  def self.campos_busca
    <<-SQL
      logradouro.logr_id, logradouro.muni_id, municipio.muni_id, unidade_federacao.unfe_id,
      bairro.bair_id, cep.cep_id, logradouro_cep.lgcp_id, logradouro_bairro.lgbr_id,
      municipio.muni_nmmunicipio AS municipio_nome,
      municipio.muni_cdibge AS municipio_ibge,
      unidade_federacao.unfe_dsuf AS uf_nome,
      unidade_federacao.unfe_dsufsigla AS uf_sigla,
      cep.cep_cdcep AS cep_codigo,
      bairro.bair_nmbairro AS bairro_nome,
      logradouro.logr_nmlogradouro AS logradouro_nome,
      logradouro.logr_nmpopular AS logradouro_popular
    SQL
  end

  def self.condicoes_busca
    <<-SQL
      concat(logradouro.logr_nmlogradouro, ' ', bairro.bair_nmbairro, ' ',
             cep.cep_cdcep, ' ', municipio.muni_nmmunicipio, ' ',
             unidade_federacao.unfe_dsuf, ' ', unidade_federacao.unfe_dsufsigla)
        ILIKE :termo
    SQL
  end

  def self.ordem_busca
    "logradouro.logr_nmlogradouro"
  end
end
