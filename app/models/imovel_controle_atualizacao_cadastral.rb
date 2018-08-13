class ImovelControleAtualizacaoCadastral < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'atualizacaocadastral.imovel_controle_atlz_cad'
  self.primary_key = 'icac_id'

  alias_attribute "id", "icac_id"
  alias_attribute "imovel_id", "imov_id"
  alias_attribute "tempo_geracao", "icac_tmgeracao"
  alias_attribute "tempo_retorno", "icac_tmretorno"
  alias_attribute "tempo_aprovacao", "icac_tmaprovacao"
  alias_attribute "situacao_atualizacao_cadastral_id", "siac_id"
  alias_attribute "imovel_retorno_id", "imre_id"
  alias_attribute "tempo_processamento", "icac_tmprocessamento"
  alias_attribute "cadastro_imovel_id", "cocr_id"
  alias_attribute "data_hora_pre_aprovacao", "icac_tmpreaprovacao"

  belongs_to :cadastro_ocorrencia, foreign_key: "cocr_id"
  belongs_to :imovel, foreign_key: "imov_id"
  belongs_to :imovel_retorno, foreign_key: "imre_id"
  belongs_to :situacao_atualizacao_cadastral, foreign_key: "siac_id"

  def descricao_ocorrencia
    cadastro_ocorrencia.try(:descricao)
  end

  def atualizar(situacao_cadastral_id)
    ImovelControleAtualizacaoCadastral.transaction do
      update(siac_id: situacao_cadastral_id, icac_tmpreaprovacao: Time.current)
      imovel_atualizacao_cadastral = ImovelAtualizacaoCadastral.find_by(imov_id: imov_id)
      imovel_atualizacao_cadastral.update(siac_id: situacao_cadastral_id) unless imovel_atualizacao_cadastral.nil?
      true
    end
  end

  def self.atualizar_lote(imovel_ids, situacao_cadastral_id)
    ImovelControleAtualizacaoCadastral.transaction do
      imovel_controle_atualizacao_cadastrais =
        ImovelControleAtualizacaoCadastral.where(imov_id: imovel_ids)
      imovel_controle_atualizacao_cadastrais.update_all(siac_id: situacao_cadastral_id, icac_tmpreaprovacao: Time.current)

      imovel_atualizacao_cadastrais = ImovelAtualizacaoCadastral.where(imov_id: imovel_ids)
      imovel_atualizacao_cadastrais.update_all(siac_id: situacao_cadastral_id)
      true
    end
  end
end
