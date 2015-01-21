class RamoAtividade < ActiveRecord::Base
  include IncrementableId
  self.table_name  = 'cadastro.ramo_atividade'
  self.primary_key = 'ratv_id'

  alias_attribute "id",            "ratv_id"                # integer NOT NULL, -- id do ramo de atividade
  alias_attribute "codigo",        "ratv_cdramoatividade"   # smallint NOT NULL, -- código do ramo de atividade
  alias_attribute "descricao",     "ratv_dsramoatividade"   # character varying(20), -- descricao do ramo de atividade
  alias_attribute "ativo",         "ratv_icuso"             # smallint, -- indicador de uso (1-ativo 2-inativo)
  alias_attribute "atualizado_em", "ratv_tmultimaalteracao" # timestamp without time zone NOT NULL DEFAULT now(),


  default_scope -> { order(:descricao) }
end
