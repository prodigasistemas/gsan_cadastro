class DebitoACobrar < ActiveRecord::Base
  self.table_name  = 'faturamento.debito_a_cobrar'
  self.primary_key = 'dbac_id'

  alias_attribute "id",                                 "dbac_id"
  alias_attribute "geracao_debito",                     "dbac_tmatudebito"
  alias_attribute "data_opcao_debito_conta_corrente",   "dbac_amreferenciadebito"
  alias_attribute "ano_mes_cobranca_debito",            "dbac_amcobrancadebito"
  alias_attribute "valor_debito",                       "dbac_vldebito"
  alias_attribute "numero_prestacao_debito",            "dbac_nnprestacaodebito"
  alias_attribute "numero_prestacao_cobradas",          "dbac_nnprestacaocobradas"
  alias_attribute "codigo_setor_comercial",             "dbac_cdsetorcomercial"
  alias_attribute "numero_quadra",                      "dbac_nnquadra"
  alias_attribute "numero_lote",                        "dbac_nnlote"
  alias_attribute "numero_subLote",                     "dbac_nnsublote"
  alias_attribute "ultima_alteracao",                   "dbac_tmultimaalteracao"
  alias_attribute "ano_mes_referencia_contabil",        "dbac_amreferenciacontabil"
  alias_attribute "percentual_taxa_juros_financiamento","dbac_pctaxajurosfinanciamento"
  alias_attribute "numero_parcela_bonus",               "dbac_nnparcelabonus"
  alias_attribute "ano_mes_referencia_prestacao",       "dbac_amreferenciaprestacao"
  alias_attribute "numero_parcelas_antecipadas",        "dbac_nnparcelasantecipadas"
  alias_attribute "data_revisao",                       "dbac_dtrevisao"
  alias_attribute "situacao_atual",                     "dcst_idatual"

  belongs_to :imovel, foreign_key:  :imov_id
  belongs_to :debito_credito_situacao_atual, foreign_key: :dcst_idatual, class_name: 'DebitoCreditoSituacao'
  belongs_to :debito_tipo, foreign_key: :dbtp_id, class_name: 'DebitoTipo'
end