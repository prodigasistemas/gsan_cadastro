class DebitoACobrarGeral < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'faturamento.debito_a_cobrar_geral'
  self.primary_key = 'dbac_id'

  alias_attribute "id",                     "dbac_id"
  alias_attribute "indicador_historico",    "dage_ichistorico"
  alias_attribute "ultima_alteracao",       "dage_tmultimaalteracao"

  belongs_to :debito_a_cobrar, foreign_key: :dbac_id, class_name: 'DebitoACobrar'
  belongs_to :debito_a_cobrar_historico, foreign_key: :dbac_id, class_name: 'DebitoACobrarHistorico'
end