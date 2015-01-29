class LogradouroTipo < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = 'cadastro.logradouro_tipo'
  self.primary_key = 'lgtp_id'

  alias_attribute "id",                           "lgtp_id"
  alias_attribute "descricao",                    "lgtp_dslogradourotipo"    # character varying(20) NOT NULL, -- descricao do tipo de logradouro
  alias_attribute "descricao_abreviada",          "lgtp_dsabreviado"         # character(3), -- descricao abreviada do tipo de logradouro
  alias_attribute "descricao_abreviada_completa", "lgtp_dsabreviadocompleto" # character(13), -- Descricao completa da abreviatura do tipo de logradouro
  alias_attribute "ativo",                        "lgtp_icuso"
  alias_attribute "atualizado_em",                "lgtp_tmultimaalteracao"

  has_many :logradouros

  scope :descricao,                     -> (descricao) { where("UPPER(lgtp_dslogradourotipo) LIKE ?", "%#{descricao.upcase}%") }
  scope :descricao_abreviada,           -> (descricao) { where("UPPER(lgtp_dsabreviado) LIKE ?", "%#{descricao.upcase}%") }
  scope :descricao_abreviada_completa,  -> (descricao) { where("UPPER(lgtp_dsabreviadocompleto) LIKE ?", "%#{descricao.upcase}%") }

  validates_presence_of   :descricao
  validates_uniqueness_of :descricao
  validates_uniqueness_of :descricao_abreviada, :descricao_abreviada_completa, allow_nil: true
  validates_inclusion_of  :ativo, in: [1,2]
  validates_length_of     :descricao,                     maximum: 20
  validates_length_of     :descricao_abreviada,           maximum: 3
  validates_length_of     :descricao_abreviada_completa,  maximum: 13
end
