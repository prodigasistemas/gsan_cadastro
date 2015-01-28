class EnderecoTipo < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = 'cadastro.endereco_tipo'
  self.primary_key = 'edtp_id'

  alias_attribute "id",            "edtp_id"                # integer NOT NULL, -- id do tipo endereco
  alias_attribute "descricao",     "edtp_dsenderecotipo"    # character varying(20), -- descricao do endereco tipo
  alias_attribute "ativo",         "edtp_icuso"             # smallint, -- indicador de uso (1-ativo 2-inativo)
  alias_attribute "atualizado_em", "edtp_tmultimaalteracao" # timestamp without time zone NOT NULL DEFAULT now()


  scope :descricao, -> (descricao) { where("UPPER(edtp_dsenderecotipo) LIKE ?", "%#{descricao.upcase}%") }

  validates_presence_of :descricao
  validates_uniqueness_of :descricao
  validates_inclusion_of :ativo, in: [1,2]
  validates_length_of :descricao, maximum: 20
end
