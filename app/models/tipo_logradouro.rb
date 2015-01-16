class TipoLogradouro < ActiveRecord::Base
  include IncrementableId

  self.table_name  = 'cadastro.logradouro_tipo'
  self.primary_key = 'lgtp_id'

  alias_attribute "id",                           "lgtp_id"
  alias_attribute "descricao",                    "lgtp_dslogradourotipo"
  alias_attribute "descricao_abreviada",          "lgtp_dsabreviado"
  alias_attribute "descricao_abreviada_completa", "lgtp_dsabreviadocompleto"
  alias_attribute "ativo",                        "lgtp_icuso"
  alias_attribute "atualizado_em",                "lgtp_tmultimaalteracao"

  has_many :logradouros

  default_scope -> { order(:descricao) }
end
