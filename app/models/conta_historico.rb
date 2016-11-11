class ContaHistorico < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'faturamento.conta_historico'
  self.primary_key = 'cnta_id'

  alias_attribute :id,                                  :cnta_id
  alias_attribute :imovel_id,                           :imov_id
  alias_attribute :ano_mes_referencia,                  :cnhi_amreferenciaconta
  alias_attribute :ligacao_agua_situacao_id,            :last_id
  alias_attribute :data_vencimento_original,            :cnhi_dtvencimentooriginal
  alias_attribute :debito_credito_situacao_id_atual,    :dcst_idatual
  alias_attribute :debito_credito_situacao_id_anterior, :dcst_idanterior  
  alias_attribute :data_ultima_alteracao,               :cnhi_tmultimaalteracao
  alias_attribute :consumo_tarifa_id,                   :cstf_id
  alias_attribute :consumo_agua,                        :cnhi_nnconsumoagua
  alias_attribute :ano_mes_referencia_contabil,         :cnhi_amreferenciacontabil
  alias_attribute :data_vencimento,                     :cnhi_dtvencimentoconta
  alias_attribute :percentual_esgoto,                   :cnhi_pcesgoto
  alias_attribute :valor_creditos,                      :cnhi_vlcreditos
  alias_attribute :valor_debitos,                       :cnhi_vldebitos
  alias_attribute :valor_esgoto,                        :cnhi_vlesgoto
  alias_attribute :valor_agua,                          :cnhi_vlagua
  alias_attribute :indicador_cobranca_multa,            :cnhi_iccobrancamulta
  alias_attribute :digito_verificador,                  :cnhi_dgverificadorconta
  alias_attribute :quadra_id,                           :qdra_id
  alias_attribute :localidade_id,                       :loca_id
  alias_attribute :ligacao_esgoto_situacao,             :lest_id

  belongs_to :imovel,                  foreign_key: :imov_id
  belongs_to :debito_credito_situacao, foreign_key: :dcst_idatual
end