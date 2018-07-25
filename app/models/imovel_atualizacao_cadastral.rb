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

  def atualizar(situacao_cadastral_id)
    ImovelAtualizacaoCadastral.transaction do
      update(siac_id: situacao_cadastral_id)
      imovel_controle_atualizacao_cadastral = ImovelControleAtualizacaoCadastral.find_by(imov_id: 875252)
      imovel_controle_atualizacao_cadastral.update(siac_id: situacao_cadastral_id, icac_tmpreaprovacao: Time.current)
    end
  end

end
