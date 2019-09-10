class ImovelAtualizacaoCadastral < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name  = 'cadastro.imovel_atlz_cadastral'
  self.primary_key = 'imov_id'

  alias_attribute :id,                            :imov_id
  alias_attribute :hidrometro_numero,             :imac_nnhidrometro
  alias_attribute :ligacao_agua_situacao_id,      :last_id
  alias_attribute :ligacao_esgoto_situacao_id,    :lest_id
  alias_attribute :situacao_cadastral_id,         :siac_id
  alias_attribute :empresa_id,                    :empr_id

  scope :podem_ser_pre_aprovados, -> { where(situacao_cadastral_id: [SituacaoAtualizacaoCadastral::SITUACOES[:"TRANSMITIDO"],
                                                                     SituacaoAtualizacaoCadastral::SITUACOES[:"REVISADO"],
                                                                     SituacaoAtualizacaoCadastral::SITUACOES[:"REVISITA"] ] ) }
  scope :podem_ficar_em_revisao, -> { where(situacao_cadastral_id: SituacaoAtualizacaoCadastral::SITUACOES[:"TRANSMITIDO"]) }
end
