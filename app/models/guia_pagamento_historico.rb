class GuiaPagamentoHistorico < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'faturamento.guia_pagamento_historico'
  self.primary_key = 'gpag_id'

  alias_attribute "id",                          "gpag_id"
  alias_attribute "ano_mes_referencia_contabil", "gphi_amreferenciacontabil"
  alias_attribute "data_emissao",                "gphi_dtemissao"
  alias_attribute "data_vencimento",             "gphi_dtvencimento"
  alias_attribute "valor_debito",                "gphi_vldebito"
  alias_attribute "ultima_alteracao",            "gphi_tmultimaalteracao"
  alias_attribute "indicado_cobranca_multa",     "gphi_iccobrancamulta"
  alias_attribute "numero_prestacao_debito",     "gphi_nnprestacaodebito"
  alias_attribute "numero_prestacao_total",      "gphi_nnprestacaototal"
  alias_attribute "observacao",                  "gphi_dsobservacao"
  alias_attribute "indicador_emitir_observacao", "gphi_icemitirobservacao"
  alias_attribute "numero_guia_fatura",          "gphi_nnguiafatura"

  belongs_to :clientes_guia_pagamento, foreign_key: 'gpag_id', class_name: 'GuiaPagamento'
  belongs_to :debito_tipo, foreign_key: 'dbtp_id', class_name: 'DebitoTipo'
  belongs_to :imovel, foreign_key:  :imov_id
  belongs_to :debito_credito_situacao_atual, foreign_key: :dcst_idatual, class_name: 'DebitoCreditoSituacao'
end