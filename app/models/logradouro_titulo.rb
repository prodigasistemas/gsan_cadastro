class LogradouroTitulo < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = 'cadastro.logradouro_titulo'
  self.primary_key = 'lgtt_id'

  alias_attribute "id",                           "lgtt_id"
  alias_attribute "descricao",                    "lgtt_dslogradourotitulo"  # character varying(25) NOT NULL, -- descricao do tipo de logradouro
  alias_attribute "descricao_abreviada",          "lgtt_dsabreviado"         # character(5), -- descricao abreviada do tipo de logradouro
  alias_attribute "descricao_abreviada_completa", "lgtt_dsabreviadocompleto" # character(13), -- Descricao completa da abreviatura do tipo de logradouro
  alias_attribute "ativo",                        "lgtt_icuso"
  alias_attribute "atualizado_em",                "lgtt_tmultimaalteracao"

  has_many :logradouros

  scope :descricao,                     -> (descricao) { where("UPPER(lgtt_dslogradourotitulo) LIKE ?", "%#{descricao.upcase}%") }
  scope :descricao_abreviada,           -> (descricao) { where("UPPER(lgtt_dsabreviado) LIKE ?", "%#{descricao.upcase}%") }
  scope :descricao_abreviada_completa,  -> (descricao) { where("UPPER(lgtt_dsabreviadocompleto) LIKE ?", "%#{descricao.upcase}%") }

  validates_presence_of   :descricao
  validates_uniqueness_of :descricao
  validates_uniqueness_of :descricao_abreviada, :descricao_abreviada_completa, allow_nil: true
  validates_inclusion_of  :ativo, in: [1,2]
  validates_length_of     :descricao,                     maximum: 25
  validates_length_of     :descricao_abreviada,           maximum: 5
  validates_length_of     :descricao_abreviada_completa,  maximum: 13
end
