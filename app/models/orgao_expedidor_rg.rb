class OrgaoExpedidorRg < ActiveRecord::Base
  include IncrementableId
  self.table_name  = 'cadastro.orgao_expedidor_rg'
  self.primary_key = 'oerg_id'

  alias_attribute "id",                  "oerg_id"                  # integer NOT NULL, -- id do orgao emissor do RG
  alias_attribute "descricao",           "oerg_dsorgaoexpedidorrg"  # character varying(50), -- descricao do orgao expedidor do RG
  alias_attribute "descricao_abreviada", "oerg_dsabreviado"         # character(6), -- descricao abreviada do orgao expedidor
  alias_attribute "ativo",               "oerg_icuso"               # smallint, -- indicador de uso (1-ativo 2-inativo)
  alias_attribute "atualizado_em",       "oerg_tmultimaalteracao"  # timestamp without time zone NOT NULL DEFAULT now() -- timestamp da inclusao/ultima alteracao

  default_scope -> { order(:descricao) }
end
