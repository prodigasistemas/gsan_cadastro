class EnderecoReferencia < ActiveRecord::Base
  include IncrementableId
  self.table_name  = 'cadastro.endereco_referencia'
  self.primary_key = 'edrf_id'

  alias_attribute "id",                  "edrf_id"                    # integer NOT NULL, -- id referencia endereco
  alias_attribute "descricao",           "edrf_dsenderecoreferencia"  # character varying(20) NOT NULL, -- descricao endereco referencia
  alias_attribute "descricao_abreviada", "edrf_dsabreviado"           # character varying(18), -- descricao abreviada do endereco referencia
  alias_attribute "ativo",               "edrf_icuso"                 # smallint, -- indicador de uso (1-ativo 2-inativo)
  alias_attribute "atualizado_em",       "edrf_tmultimaalteracao"     # timestamp without time zone NOT NULL DEFAULT now()

  default_scope -> { order(:descricao) }
end
