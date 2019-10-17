class CreditoARealizar < ActiveRecord::Base
  self.table_name  = 'faturamento.credito_a_realizar'
  self.primary_key = 'crar_id'

  alias_attribute "id",                                 "crar_id"
  alias_attribute "geracao_debito",                     "crar_tmatucredito"
  alias_attribute "ano_mes_referencia_credito",         "crar_amreferenciacredito"
  alias_attribute "ano_mes_cobranca_credito",           "crar_amcobrancacredito"
  alias_attribute "valor_credito",                      "crar_vlcredito"
  alias_attribute "numero_prestacao_credito",           "crar_nnprestacaocredito"
  alias_attribute "numero_prestacao_realizadas",        "crar_nnprestacaorealizadas"
  alias_attribute "codigo_setor_comercial",             "crar_cdsetorcomercial"
  alias_attribute "numero_quadra",                      "crar_nnquadra"
  alias_attribute "numero_lote",                        "crar_nnlote"
  alias_attribute "numero_subLote",                     "crar_nnsublote"
  alias_attribute "ultima_alteracao",                   "crar_tmultimaalteracao"
  alias_attribute "ano_mes_referencia_contabil",        "crar_amreferenciacontabil"
  alias_attribute "valor_residual_mes_anterior",        "crar_vlresidualmesanterior"
  alias_attribute "numero_parcela_bonus",               "crar_nnparcelabonus"
  alias_attribute "ano_mes_referencia_prestacao",       "crar_amreferenciaprestacao"
  alias_attribute "numero_parcelas_antecipadas",        "crac_nnparcelasantecipadas"
  alias_attribute "valor_residual_concedido_mes",       "crar_vlresidualconcedidomes"
  
  belongs_to :imovel, foreign_key:  :imov_id
  belongs_to :debito_credito_situacao_atual, foreign_key: :dcst_idatual, class_name: 'DebitoCreditoSituacao'
  belongs_to :credito_tipo, foreign_key: :crti_id, class_name: 'CreditoTipo'
end