class Parcelamento < ActiveRecord::Base
  include IncrementableId
  include API::Model
  include API::Filterable

  self.table_name = 'cobranca.parcelamentos'
  self.primary_key = 'parc_id'

  alias_attribute "id",                                   "parc_id"
  alias_attribute "data_hora_parcelamento",               "parc_tmparcelamento"
  alias_attribute "ano_mes_referencia",                   "parc_amreferenciafaturamento"
  alias_attribute "valor_conta",                          "parc_vlconta"
  alias_attribute "valor_servicos_cobrar",                "parc_vlservicosacobrar"
  alias_attribute "valor_atualizacao_monetaria",          "parc_vlatualizacaomonetaria"
  alias_attribute "valor_juros_mora",                     "parc_vljurosmora"
  alias_attribute "valor_multa",                          "parc_vlmulta"
  alias_attribute "valor_debito_atualizado",              "parc_vldebitoatualizado"
  alias_attribute "valor_desconto_acrescimos",            "parc_vldescontoacrescimos"
  alias_attribute "valor_entrada",                        "parc_vlentrada"
  alias_attribute "valor_juros_parcelamento",             "parc_vljurosparcelamento"
  alias_attribute "numero_prestacoes",                    "parc_nnprestacoes"
  alias_attribute "valor_prestacoes",                     "parc_vlprestacao"
  alias_attribute "valor_desconto_antiguidade",           "parc_vldescontoantiguidade"
  alias_attribute "indicador_debito_a_cobrar",            "parc_icdebitoacobrar"
  alias_attribute "valor_desconto_inatividade",           "parc_vldescontoinatividade"
  alias_attribute "percentual_desconto_acrescimos",       "parc_pcdescontoacrescimos"
  alias_attribute "indicador_acrescimos_impontualidade",  "parc_icacrescimosimpontualdade"
  alias_attribute "valor_guia_pagamento",                 "parc_vlguiapapagamento"
  alias_attribute "imovel_id",                            "imov_id"
  alias_attribute "registro_atendimento_id",              "rgat_id"
  alias_attribute "percentual_desconto_antiguidade",      "parc_pcdescontoantiguidade"
  alias_attribute "funcionario_id",                       "func_id"
  alias_attribute "percentual_desconto_inatividade",      "parc_pcdescontoinatividade"
  alias_attribute "ligacao_agua_situacao_id",             "last_id"
  alias_attribute "ligacao_esgoto_situacao_id",           "lest_id"
  alias_attribute "codigo_setor_comercial",               "parc_cdsetorcomercial"
  alias_attribute "numero_quadra",                        "parc_nnquadra"
  alias_attribute "localidade_id",                        "loca_id"
  alias_attribute "quadra_id",                            "qdra_id"
  alias_attribute "ultima_alteracao",                     "parc_tmultimaalteracao"
  alias_attribute "valor_credito_realizar",               "parc_vlcreditoarealizar"
  alias_attribute "perfil_id",                            "iper_id"
  alias_attribute "tipo_parcelamento_id",                 "pctp_id"
  alias_attribute "forma_cobranca_id",                    "cbfm_id"
  alias_attribute "perfil_parcelamento_id",               "pcpf_id"  
  alias_attribute "situacao_parcelamento_id",             "pcst_id"
  alias_attribute "valor_parcelamentos_cobrar",           "parc_vlparcelamentosacobrar"
  alias_attribute "indicador_restabelecimento",           "parc_icrestabelecimento"
  alias_attribute "indicador_contas_revisao",             "parc_iccontasrevisao"
  alias_attribute "indicador_guias_pagamento",            "parc_icguiaspagamento"
  alias_attribute "indicador_credito_realizar",           "parc_iccreditoarealizar"
  alias_attribute "motivo_desfazer_parcelamento_id",      "pmdz_id"
  alias_attribute "taxa_juros",                           "parc_txjuros"
  alias_attribute "indicador_confirmacao",                "parc_icconfirmacao"
  alias_attribute "cliente_id",                           "clie_id"
  alias_attribute "usuario_id",                           "usur_id"
  alias_attribute "resolucao_diretoria",                  "rdir_id"
  alias_attribute "valor_desconto_sancao",                "parc_vldescontosancao"
  alias_attribute "valor_desconto_tarifa_social",         "parc_vldescontotarsoc"
  alias_attribute "numero_parcelas_paga_consecutivas",    "parc_nnparcelaspagasconsecs"
  alias_attribute "usuario_desfez_parcelamento",          "usur_iddesfaz"
  alias_attribute "valor_desconto_debito_total",          "parc_vldescontodebtotal"
  alias_attribute "valor_desconto_faixa",                 "parc_vldescontofaixa"
  alias_attribute "data_hora_cancelamento",               "parc_tmcancelamento"
  alias_attribute "usuario_cancelamento_id",              "usur_idcancelamento"
  alias_attribute "motivo_cancelamento_parcelamento_id",  "pmca_id"

  belongs_to :imovel, foreign_key: :imovel_id
  belongs_to :situacao_parcelamento, foreign_key: :situacao_parcelamento_id, class_name: 'ParcelamentoSituacao'

  delegate :situacao_parcelamento,     :to => :imovel, :allow_nil => true, :prefix => true
end