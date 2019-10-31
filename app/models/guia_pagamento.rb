class GuiaPagamento < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'faturamento.guia_pagamento'
  self.primary_key = 'gpag_id'

  alias_attribute "id",                          "gpag_id"
  alias_attribute "ano_mes_referencia_contabil", "gpag_amreferenciacontabil"
  alias_attribute "data_emissao",                "gpag_dtemissao"
  alias_attribute "data_vencimento",             "gpag_dtvencimento"
  alias_attribute "valor_debito",                "gpag_vldebito"
  alias_attribute "ultima_alteracao",            "gpag_tmultimaalteracao"
  alias_attribute "indicado_cobranca_multa",     "gpag_iccobrancamulta"
  alias_attribute "numero_prestacao_debito",     "gpag_nnprestacaodebito"
  alias_attribute "numero_prestacao_total",      "gpag_nnprestacaototal"
  alias_attribute "numero_guia",                 "gpag_nnnumeroguia"
  alias_attribute "ano_guia",                    "gpag_nnanoguia"
  alias_attribute "lote_pagamento",              "gpag_nnlotepagamento"
  alias_attribute "observacao",                  "gpag_dsobservacao"
  alias_attribute "indicador_emitir_observacao", "gpag_icemitirobservacao"
  alias_attribute "numero_guia_fatura",          "gpag_nnguiafatura"

  belongs_to :clientes_guia_pagamento, foreign_key: 'gpag_id', class_name: 'GuiaPagamento'
  belongs_to :debito_tipo, foreign_key: 'dbtp_id', class_name: 'DebitoTipo'
  belongs_to :imovel, foreign_key:  :imov_id
  belongs_to :debito_credito_situacao_atual, foreign_key: :dcst_idatual, class_name: 'DebitoCreditoSituacao'

end