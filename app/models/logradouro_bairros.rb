class LogradouroBairros < ActiveRecord::Base
  include IncrementableId

  self.table_name  = 'cadastro.logradouro_bairro'
  self.primary_key = 'lgbr_id'

  alias_attribute "id",            "lgbr_id"
  alias_attribute "logradouro_id", "logr_id"
  alias_attribute "bairro_id",     "bair_id"
  alias_attribute "ativo",         "lgbr_icuso"
  alias_attribute "atualizado_em", "lgbr_tmultimaalteracao"

  belongs_to :logradouro, foreign_key: :logr_id
  belongs_to :bairro, foreign_key: :bair_id
end
