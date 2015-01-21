class PessoaSexo < ActiveRecord::Base
  include IncrementableId
  self.table_name  = 'cadastro.pessoa_sexo'
  self.primary_key = 'psex_id'

  alias_attribute "id",            "psex_id"                  # integer NOT NULL, -- id do sexo da pessoa
  alias_attribute "descricao",     "psex_dspessoasexo"        # character varying(20), -- descricao do sexo da pessoa
  alias_attribute "ativo",         "psex_icuso"               # smallint, -- indicador de uso (1-ativo 2-inativo)
  alias_attribute "atualizado_em", "psex_tmultimaalteracao"   # timestamp without time zone NOT NULL DEFAULT now()
end
