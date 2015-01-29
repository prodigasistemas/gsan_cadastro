class FoneTipo < ActiveRecord::Base
  include IncrementableId

  self.table_name  = 'cadastro.fone_tipo'
  self.primary_key = 'fnet_id'

  alias_attribute "id",            "fnet_id"                # integer NOT NULL, -- id do tipo de telefone
  alias_attribute "descricao",     "fnet_dsfonetipo"        # character varying(20), -- descricao do tipo de fone
  alias_attribute "ativo",         "fnet_icuso"             # smallint, -- indicador de uso(1-ativo 2-inativo)
  alias_attribute "atualizado_em", "fnet_tmultimaalteracao" # timestamp without time zone NOT NULL DEFAULT now(),

  validates_length_of :descricao, maximum: 20
end
