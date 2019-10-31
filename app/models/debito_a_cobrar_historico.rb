class DebitoACobrarHistorico < ActiveRecord::Base
  self.table_name  = 'faturamento.deb_a_cobrar_hist'
  self.primary_key = 'dbac_id'

  alias_attribute "id",                                 "dbac_id"
  alias_attribute "geracao_debito",                     "dahi_tmatudebito"
  alias_attribute "data_opcao_debito_conta_corrente",   "dahi_amreferenciadebito"
  alias_attribute "ano_mes_cobranca_debito",            "dahi_amcobrancadebito"
  alias_attribute "ano_mes_referencia_contabil",        "dahi_amreferenciacontabil"
  alias_attribute "valor_debito",                       "dahi_vldebito"
  alias_attribute "numero_prestacao_debito",            "dahi_nnprestacaodebito"
  alias_attribute "numero_prestacao_cobradas",          "dahi_nnprestacaocobradas"
  alias_attribute "codigo_setor_comercial",             "dahi_cdsetorcomercial"
  alias_attribute "numero_quadra",                      "dahi_nnquadra"
  alias_attribute "numero_lote",                        "dahi_nnlote"
  alias_attribute "numero_subLote",                     "dahi_nnsublote"
  alias_attribute "ultima_alteracao",                   "dahi_tmultimaalteracao"
  alias_attribute "percentual_taxa_juros_financiamento","dahi_pctaxajurosfinanciamento"
  alias_attribute "numero_parcela_bonus",               "dahi_nnparcelabonus"

  belongs_to :imovel, foreign_key:  :imov_id
  belongs_to :debito_credito_situacao_atual, foreign_key: :dcst_idatual, class_name: 'DebitoCreditoSituacao'
  belongs_to :debito_tipo, foreign_key: :dbtp_id, class_name: 'DebitoTipo'
end