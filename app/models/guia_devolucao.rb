class GuiaDevolucao < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'arrecadacao.guia_devolucao'
  self.primary_key = 'gdev_id'

  alias_attribute "id",                                "gdev_id"
  alias_attribute "data_emissao",                      "gdev_dtemissao"
  alias_attribute "data_validade",                     "gdev_dtvalidade"
  alias_attribute "valor_devolucao",                   "gdev_vldevolucao"
  alias_attribute "ultima_alteracao",                  "gdev_tmultimaalteracao"
  alias_attribute "ano_mes_referencia_contabil",       "gdev_amreferenciacontabil"
  alias_attribute "ano_mes_referencia_guia_devolucao", "gdev_amreferenciaguiadevolucao"

  belongs_to :conta, foreign_key: 'cnta_id'
  belongs_to :documento_tipo, foreign_key: 'dotp_id'
  belongs_to :guia_pagamento, foreign_key: 'gpag_id'
  
end