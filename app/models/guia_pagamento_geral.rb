class GuiaPagamentoGeral < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'faturamento.guia_pagamento_geral'
  self.primary_key = 'gpag_id'

  alias_attribute "id",                     "gpag_id"
  alias_attribute "indicador_historico",    "gpag_ichistorico"
  alias_attribute "ultima_alteracao",       "gpag_tmultimaalteracao"
end