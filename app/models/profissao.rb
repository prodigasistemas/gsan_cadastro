class Profissao < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = 'cadastro.profissao'
  self.primary_key = 'prof_id'
  alias_attribute "id",            "prof_id"                # integerNOT NULL, -- id da profissao
  alias_attribute "codigo",        "prof_cdprofissao"       # integer NOT NULL, -- codigo da profissao
  alias_attribute "descricao",     "prof_dsprofissao"       # character varying(30), -- descricao da profissao
  alias_attribute "ativo",         "prof_icuso"             # smallint, -- indicador de uso (1-ativo 2-inativo)
  alias_attribute "atualizado_em", "prof_tmultimaalteracao" # timestamp without time zone NOT NULL DEFAULT now(),

  scope :descricao, -> (descricao) { where("UPPER(prof_dsprofissao) LIKE ?", "%#{descricao.upcase}%") }
  scope :codigo,    -> (codigo)    { where codigo: codigo }

  validates_presence_of :codigo, :descricao
  validates_uniqueness_of :codigo, :descricao
  validates_inclusion_of :ativo, in: [1,2]
  validates_length_of :descricao, maximum: 30
end
