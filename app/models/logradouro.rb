class Logradouro < ActiveRecord::Base
  include IncrementableId

  self.table_name  = 'cadastro.logradouro'
  self.primary_key = 'logr_id'

  alias_attribute "id",                   "logr_id"
  alias_attribute "nome",                 "logr_nmlogradouro"
  alias_attribute "titulo_logradouro_id", "lgtt_id"
  alias_attribute "logradouro_tipo_id",   "lgtp_id"
  alias_attribute "municipio_id",         "muni_id"
  alias_attribute "ativo",                "logr_icuso"
  alias_attribute "atualizado_em",        "logr_tmultimaalteracao"
  alias_attribute "nome_popular",         "logr_nmpopular"

  has_many :logradouro_ceps, foreign_key: "logr_id", inverse_of: :logradouro
  has_many :ceps, through: :logradouro_ceps
  has_many :logradouro_bairros, foreign_key: "logr_id", inverse_of: :logradouro
  has_many :bairros, through: :logradouro_bairros
  belongs_to :titulo_logradouro, foreign_key: "lgtt_id"
  belongs_to :tipo_logradouro, foreign_key: "lgtp_id"
  belongs_to :municipio, foreign_key: "muni_id"

  accepts_nested_attributes_for :logradouro_ceps
  accepts_nested_attributes_for :logradouro_bairros
end
