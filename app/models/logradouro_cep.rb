class LogradouroCep < ActiveRecord::Base
  include IncrementableId

  self.table_name  = 'cadastro.logradouro_cep'
  self.primary_key = 'lgcp_id'

  alias_attribute "id",            "lgcp_id"
  alias_attribute "logradouro_id", "logr_id"
  alias_attribute "ativo",         "lgcp_icuso"
  alias_attribute "atualizado_em", "lgcp_tmultimaalteracao"

  belongs_to :logradouro, foreign_key: :logr_id, inverse_of: :logradouro_ceps
  belongs_to :cep, foreign_key: :cep_id, inverse_of: :logradouro_ceps
end
