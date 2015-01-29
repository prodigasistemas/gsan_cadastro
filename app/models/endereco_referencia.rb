class EnderecoReferencia < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = 'cadastro.endereco_referencia'
  self.primary_key = 'edrf_id'

  alias_attribute "id",                  "edrf_id"                    # integer NOT NULL, -- id referencia endereco
  alias_attribute "descricao",           "edrf_dsenderecoreferencia"  # character varying(20) NOT NULL, -- descricao endereco referencia
  alias_attribute "descricao_abreviada", "edrf_dsabreviado"           # character varying(18), -- descricao abreviada do endereco referencia
  alias_attribute "ativo",               "edrf_icuso"                 # smallint, -- indicador de uso (1-ativo 2-inativo)
  alias_attribute "atualizado_em",       "edrf_tmultimaalteracao"     # timestamp without time zone NOT NULL DEFAULT now()

  scope :descricao,           -> (descricao) { where("UPPER(edrf_dsenderecoreferencia) LIKE ?", "%#{descricao.upcase}%") }
  scope :descricao_abreviada, -> (descricao) { where("UPPER(edrf_dsabreviado) LIKE ?", "%#{descricao.upcase}%") }

  validates_presence_of   :descricao_abreviada, :descricao
  validates_uniqueness_of :descricao_abreviada, :descricao
  validates_inclusion_of  :ativo, in: [1,2]
  validates_length_of     :descricao,           maximum: 20
  validates_length_of     :descricao_abreviada, maximum: 18
end
