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
  has_many :visitas, foreign_key: :icac_id

  scope :podem_ser_pre_aprovados, -> { where(situacao_atualizacao_cadastral_id: [ SituacaoAtualizacaoCadastral::SITUACOES[:"TRANSMITIDO"],
                                                                                  SituacaoAtualizacaoCadastral::SITUACOES[:"REVISADO"],
                                                                                  SituacaoAtualizacaoCadastral::SITUACOES[:"REVISITA"] ] ) }
  scope :podem_ficar_em_revisao, -> { where(situacao_atualizacao_cadastral_id: SituacaoAtualizacaoCadastral::SITUACOES[:"TRANSMITIDO"]) }
  scope :podem_ser_pre_aprovados_em_lote, -> { where(situacao_atualizacao_cadastral_id: [ SituacaoAtualizacaoCadastral::SITUACOES[:"TRANSMITIDO"],
                                                                                          SituacaoAtualizacaoCadastral::SITUACOES[:"REVISITA"] ] ) }

  def is_situacao_do_gsan?
    SituacaoAtualizacaoCadastral::GSAN_SITUACOES.include? situacao_atualizacao_cadastral_id
  end

  def is_revisita?
    SituacaoAtualizacaoCadastral::SITUACOES[:"REVISITA"] == situacao_atualizacao_cadastral_id
  end

  def descricao_ocorrencia
    cadastro_ocorrencia.try(:descricao)
  end

  def atualizar(situacao_cadastral_id, revisoes = [])
    ImovelControleAtualizacaoCadastral.transaction do
      return false if is_situacao_do_gsan?
      situacao_anterior = situacao_atualizacao_cadastral_id
      update(siac_id: situacao_cadastral_id, icac_tmpreaprovacao: Time.current)
      puts "-------->>>> IMOV_ID: " + imov_id
      imovel_atualizacao_cadastral = ImovelAtualizacaoCadastral.find_by(imov_id: imov_id)
      imovel_atualizacao_cadastral.update(siac_id: situacao_cadastral_id) unless imovel_atualizacao_cadastral.nil?
      ImovelControleAtualizacaoCadastral.atualizar_valores_colunas(situacao_cadastral_id, imov_id, revisoes, situacao_anterior)
      true
    end
  end

  def self.atualizar_valores_colunas(situacao_cadastral_id, imov_id, revisoes = [], situacao_anterior)
    if [SituacaoAtualizacaoCadastral::SITUACOES[:"REVISADO"], SituacaoAtualizacaoCadastral::SITUACOES[:"PRE APROVADO"]].include?(situacao_cadastral_id.try(:to_i)) and
          situacao_anterior != SituacaoAtualizacaoCadastral::SITUACOES[:"REVISADO"]
      ColunaAtualizacaoCadastral.aplicar_valores_da_pre_aprovacao_ou_revisao(imov_id, revisoes)
    end
  end

  def self.atualizar_lote(imovel_ids, situacao_cadastral_id)
    ImovelControleAtualizacaoCadastral.transaction do
      if situacao_cadastral_id.try(:to_i) == SituacaoAtualizacaoCadastral::SITUACOES[:"PRE APROVADO"]
        ColunaAtualizacaoCadastralJob.perform_async(imovel_ids, situacao_cadastral_id)
      else
        imovel_controle_atualizacao_cadastrais = ImovelControleAtualizacaoCadastral.where(imov_id: imovel_ids).podem_ficar_em_revisao
        imovel_atualizacao_cadastrais = ImovelAtualizacaoCadastral.where(imov_id: imovel_ids).podem_ficar_em_revisao
        imovel_controle_atualizacao_cadastrais.update_all(siac_id: situacao_cadastral_id, icac_tmpreaprovacao: Time.current)
        imovel_atualizacao_cadastrais.update_all(siac_id: situacao_cadastral_id)
      end
      true
    end
  end
end
