class Municipio < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = 'cadastro.municipio'
  self.primary_key = 'muni_id'

  alias_attribute "id",                         "muni_id"
  alias_attribute "nome",                       "muni_nmmunicipio"
  alias_attribute "cep_inicial",                "muni_cdcepinicio"
  alias_attribute "cep_final",                  "muni_cdcepfim"
  alias_attribute "ddd",                        "muni_cdddd"
  alias_attribute "regiao_desenvolvimento_id",  "rdes_id"
  alias_attribute "micro_regiao_id",            "mreg_id"
  alias_attribute "uf_id",                      "unfe_id"
  alias_attribute "ativo",                      "muni_icuso"
  alias_attribute "atualizado_em",              "muni_tmultimaalteracao"
  alias_attribute "inicio_concessao",           "muni_dtconcessaoinicio"
  alias_attribute "fim_concessao",              "muni_dtconcessaofim"
  alias_attribute "codigo_ibge",                "muni_cdibge"
  alias_attribute "quadro_bairro",              "muni_icrelacionquadrabairro"

  belongs_to :uf, class_name: "UnidadeFederacao", foreign_key: "unfe_id"
  belongs_to :micro_regiao, foreign_key: "mreg_id"
  belongs_to :regiao_desenvolvimento, foreign_key: "rdes_id"
  has_many :logradouros

  validates_presence_of :nome, :codigo_ibge,
                        :micro_regiao_id, :regiao_desenvolvimento_id,
                        :uf_id, :ddd

  scope :join, -> {
    includes(:uf, :micro_regiao, :regiao_desenvolvimento).
    joins(:uf, :micro_regiao, :regiao_desenvolvimento).
    order(:nome)
  }

  scope :nome, -> (nome) { where("UPPER(muni_nmmunicipio) LIKE ?", "%#{nome.upcase}%") }
  scope :uf_id, -> (id) { where uf_id: id }
  scope :micro_regiao_id, -> (id) { where micro_regiao_id: id }
  scope :regiao_desenvolvimento_id, -> (id) { where regiao_desenvolvimento_id: id }
  scope :ddd, -> (ddd) { where ddd: ddd }
  scope :codigo_ibge, -> (codigo) { where codigo_ibge: codigo }
  scope :cep_inicial, -> (cep) { where cep_inicial: cep }
  scope :cep_final, -> (cep) { where cep_final: cep }
end
