class UnidadeFederacao < ActiveRecord::Base
  include IncrementableId

  self.table_name  = 'cadastro.unidade_federacao'
  self.primary_key = 'unfe_id'

  alias_attribute "id",            "unfe_id"
  alias_attribute "descricao",     "unfe_dsuf"
  alias_attribute "sigla",         "unfe_dsufsigla"
  alias_attribute "atualizado_em", "unfe_tmultimaalteracao"

  default_scope -> { order(:descricao) }
end
