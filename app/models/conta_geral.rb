class ContaGeral < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  INDICADOR = {
    :historico => 1
  }

  self.table_name  = 'faturamento.conta_geral'
  self.primary_key = 'cnta_id'

  alias_attribute "id",                     "cnta_id"
  alias_attribute "indicador_historico",     "cntg_ichistorico"
  alias_attribute "ultima_alteracao",        "cntg_tmultimaalteracao"

  belongs_to :conta, foreign_key: 'cnta_id', class_name: 'Conta'
  belongs_to :conta_historico, foreign_key: 'cnta_id', class_name: 'ContaHistorico'
end