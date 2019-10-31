class GuiaPagamentoGeral < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'faturamento.guia_pagamento_geral'
  self.primary_key = 'gpag_id'

  alias_attribute "id",                     "gpag_id"
  alias_attribute "indicador_historico",    "gpag_ichistorico"
  alias_attribute "ultima_alteracao",       "gpag_tmultimaalteracao"

  belongs_to :guia_pagamento_historico, foreign_key: 'gpag_id',class_name: 'GuiaPagamentoHistorico'
end