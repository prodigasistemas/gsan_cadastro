class OrgaoExpedidorRg < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = 'cadastro.orgao_expedidor_rg'
  self.primary_key = 'oerg_id'

  alias_attribute "id",                  "oerg_id"                  # integer NOT NULL, -- id do orgao emissor do RG
  alias_attribute "descricao",           "oerg_dsorgaoexpedidorrg"  # character varying(50), -- descricao do orgao expedidor do RG
  alias_attribute "descricao_abreviada", "oerg_dsabreviado"         # character(6), -- descricao abreviada do orgao expedidor
  alias_attribute "ativo",               "oerg_icuso"               # smallint, -- indicador de uso (1-ativo 2-inativo)
  alias_attribute "atualizado_em",       "oerg_tmultimaalteracao"   # timestamp without time zone NOT NULL DEFAULT now() -- timestamp da inclusao/ultima alteracao

  scope :descricao,           -> (descricao) { where("UPPER(oerg_dsorgaoexpedidorrg) LIKE ?", "%#{descricao.upcase}%") }
  scope :descricao_abreviada, -> (descricao) { where("UPPER(oerg_dsabreviado) LIKE ?", "%#{descricao.upcase}%") }

  validates_presence_of   :descricao_abreviada, :descricao
  validates_uniqueness_of :descricao_abreviada, :descricao
  validates_inclusion_of  :ativo, in: [1,2]
  validates_length_of     :descricao,           maximum: 50
  validates_length_of     :descricao_abreviada, maximum: 6
end
