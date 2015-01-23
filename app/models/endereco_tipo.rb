class EnderecoTipo < ActiveRecord::Base
  include IncrementableId
  self.table_name  = 'cadastro.endereco_tipo'
  self.primary_key = 'edtp_id'

  alias_attribute "id",            "edtp_id"                # integer NOT NULL, -- id do tipo endereco
  alias_attribute "descricao",     "edtp_dsenderecotipo"    # character varying(20), -- descricao do endereco tipo
  alias_attribute "ativo",         "edtp_icuso"             # smallint, -- indicador de uso (1-ativo 2-inativo)
  alias_attribute "atualizado_em", "edtp_tmultimaalteracao" # timestamp without time zone NOT NULL DEFAULT now()
end
