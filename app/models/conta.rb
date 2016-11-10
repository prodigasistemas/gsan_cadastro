class Conta < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'faturamento.conta'
  self.primary_key = 'cnta_id'

  alias_attribute :id,                               :cnta_id
  alias_attribute :imovel_id,                        :imov_id
  alias_attribute :mes_ano_referencia,               :cnta_amreferenciaconta
  alias_attribute :ligacao_agua_situacao_id,         :last_id
  alias_attribute :data_vencimento_original,         :cnta_dtvencimentooriginal
  alias_attribute :debito_credito_situacao_id_atual, :dcst_idatual
  alias_attribute :data_ultima_alteracao,            :cnta_tmultimaalteracao
  alias_attribute :consumo_tarifa_id,                :cstf_id
  alias_attribute :consumo_agua,                     :cnta_nnconsumoagua
  alias_attribute :ano_mes_referencia_contabil,      :cnta_amreferenciacontabil
  alias_attribute :data_vencimento,                  :cnta_dtvencimentoconta
  alias_attribute :percentual_esgoto,                :cnta_pcesgoto
  alias_attribute :valor_creditos,                   :cnta_vlcreditos
  alias_attribute :valor_debitos,                    :cnta_vldebitos
  alias_attribute :valor_esgoto,                     :cnta_vlesgoto
  alias_attribute :valor_agua,                       :cnta_vlagua
  alias_attribute :indicador_cobranca_multa,         :cnta_iccobrancamulta
  alias_attribute :digito_verificador,               :cnta_dgverificadorconta
  alias_attribute :quadra_id,                        :qdra_id
  alias_attribute :localidade_id,                    :loca_id
  alias_attribute :ligacao_esgoto_situacao,          :lest_id

  belongs_to :imovel,                  foreign_key: :imov_id
  belongs_to :debito_credito_situacao, foreign_key: :dcst_idatual

  scope :do_imovel_com_referencia, -> (imovel_id, referencia) do
    where(imovel_id: imovel_id, mes_ano_referencia: referencia).first
  end
end