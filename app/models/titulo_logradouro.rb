class TituloLogradouro < ActiveRecord::Base
  include IncrementableId

  self.table_name  = 'cadastro.logradouro_titulo'
  self.primary_key = 'lgtt_id'

  alias_attribute "id",                           "lgtt_id"
  alias_attribute "descricao",                    "lgtt_dslogradourotitulo"
  alias_attribute "descricao_abreviada",          "lgtt_dsabreviado"
  alias_attribute "descricao_abreviada_completa", "lgtt_dsabreviadocompleto"
  alias_attribute "ativo",                        "lgtt_icuso"
  alias_attribute "atualizado_em",                "lgtt_tmultimaalteracao"

  belongs_to :logradouro

  default_scope -> { order(:descricao) }
end
