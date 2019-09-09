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
  alias_attribute "data_hora_reprovacao", "icac_tmreprovacaolote"
  alias_attribute "lote", "icac_lote"

  belongs_to :cadastro_ocorrencia, foreign_key: "cocr_id", optional: true
  belongs_to :imovel, foreign_key: "imov_id"
  belongs_to :imovel_retorno, foreign_key: "imre_id"
  belongs_to :situacao_atualizacao_cadastral, foreign_key: "siac_id"
  has_many :visitas, foreign_key: :icac_id
  has_one :atualizacao_cadastral, foreign_key: :imov_id

  scope :podem_ser_pre_aprovados, -> { where(situacao_atualizacao_cadastral_id: [ SituacaoAtualizacaoCadastral::SITUACOES[:"TRANSMITIDO"],
                                                                                  SituacaoAtualizacaoCadastral::SITUACOES[:"REVISADO"],
                                                                                  SituacaoAtualizacaoCadastral::SITUACOES[:"REVISITA"] ] ) }
  scope :podem_ficar_em_revisao, -> { where(situacao_atualizacao_cadastral_id: SituacaoAtualizacaoCadastral::SITUACOES[:"TRANSMITIDO"]) }
  scope :podem_ser_pre_aprovados_em_lote, -> { where(situacao_atualizacao_cadastral_id: [ SituacaoAtualizacaoCadastral::SITUACOES[:"TRANSMITIDO"],
                                                                                          SituacaoAtualizacaoCadastral::SITUACOES[:"REVISITA"] ] ) }

  scope :reprovados, -> { where("icac_tmreprovacaolote is not null") }

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
      puts  imov_id
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

  def self.reprovados_filtro(params)
    empresa_id = params[:empresa_id] || 0
    query = <<-SQL
      select ic.icac_lote as lote,
             ic.imov_id as imovel_id,
             cocr.cocr_dscadastroocorrencia as ocorrencia_cadastro,
             u.usur_nmusuario as agente_cadastral,
             ic.icac_tmreprovacaolote as data_hora_reprovacao
      from atualizacaocadastral.imovel_controle_atlz_cad ic
      inner join atualizacaocadastral.visita vis on vis.icac_id = ic.icac_id
      inner join cadastro.cadastro_ocorrencia cocr on cocr.cocr_id = vis.cocr_id
      inner join cadastro.imovel_atlz_cadastral iatlz on iatlz.imov_id = ic.imov_id
      left join seguranca.usuario u on u.usur_id = vis.usur_id
      where 1 = 1
          and icac_tmreprovacaolote is not null
          and vis.vist_id = (select max(v2.vist_id) from atualizacaocadastral.visita v2 where v2.icac_id = ic.icac_id)
          and iatlz.empr_id = #{empresa_id}
    SQL
    query << "\nand vis.usur_id = #{params[:leiturista_id]}" unless params[:leiturista_id].blank?
    query << "\nand ic.icac_lote = #{params[:lote]}" unless params[:lote].blank?
    query << "\nand ic.imov_id = #{params[:matricula]}" unless params[:matricula].blank?
    query << "\nand ic.icac_tmreprovacaolote::Date = '#{params[:data_hora_reprovacao].try(:to_date).try(:strftime)}'" unless params[:data_hora_reprovacao].blank?

    if params[:ocorrencias_cadastro].present? and
        params[:ocorrencias_cadastro] != AtualizacaoCadastral::TODOS
      query << "\nand cocr.cocr_icvalidacao = #{params[:ocorrencias_cadastro]}"
      query << "\nand vis.cocr_id = #{params[:cadastro_ocorrencia_id]}" if params[:cadastro_ocorrencia_id].present?
    end

    ActiveRecord::Base.connection.execute("#{query}\norder by ic.icac_tmreprovacaolote, ic.icac_lote, ic.imov_id, u.usur_nmusuario")
  end
end
