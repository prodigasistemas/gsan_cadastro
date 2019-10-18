class CreditoARealizarHistorico < ActiveRecord::Base
  self.table_name  = 'faturamento.cred_a_realiz_hist'
  self.primary_key = 'crar_id'

  alias_attribute "id",                                 "crar_id"
  alias_attribute "geracao_debito",                     "carh_tmatucredito"
  alias_attribute "ano_mes_referencia_credito",         "carh_amreferenciacredito"
  alias_attribute "ano_mes_cobranca_credito",           "carh_amcobrancacredito"
  alias_attribute "valor_credito",                      "carh_vlcredito"
  alias_attribute "numero_prestacao_credito",           "carh_nnprestacaocredito"
  alias_attribute "numero_prestacao_realizadas",        "carh_nnprestacaorealizadas"
  alias_attribute "codigo_setor_comercial",             "carh_cdsetorcomercial"
  alias_attribute "numero_quadra",                      "carh_nnquadra"
  alias_attribute "numero_lote",                        "carh_nnlote"
  alias_attribute "numero_subLote",                     "carh_nnsublote"
  alias_attribute "ultima_alteracao",                   "carh_tmultimaalteracao"
  alias_attribute "ano_mes_referencia_contabil",        "carh_amreferenciacontabil"
  alias_attribute "valor_residual_mes_anterior",        "carh_vlresidualmesanterior"
  alias_attribute "numero_parcela_bonus",               "carh_nnparcelabonus"
  
  belongs_to :imovel, foreign_key:  :imov_id
  belongs_to :debito_credito_situacao_atual, foreign_key: :dcst_idatual, class_name: 'DebitoCreditoSituacao'
  belongs_to :credito_tipo, foreign_key: :crti_id, class_name: 'CreditoTipo'
end