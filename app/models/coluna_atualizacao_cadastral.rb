class ColunaAtualizacaoCadastral < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'seguranca.tab_col_atlz_cadastral'
  self.primary_key = 'tcac_id'

  alias_attribute :id,                       :tcac_id
  alias_attribute :atualizacao_cadastral_id, :tatc_id
  alias_attribute :tabela_coluna_id,         :tbco_id
  alias_attribute :valor_anterior,           :tcac_cnvaloranterior
  alias_attribute :valor_atual,              :tcac_cnvalortransmitido
  alias_attribute :autorizado,               :tcac_icautorizado
  alias_attribute :data_processamento,       :tcac_dtvalidacao
  alias_attribute :data_ultima_atualizacao,  :tcac_ultimaatualizacao
  alias_attribute :usuario_id,               :usur_id
  alias_attribute :valor_revisado,           :tcac_cnvalorrevisado
  alias_attribute :valor_pre_aprovado,       :tcac_cnvalorpreaprovado

  belongs_to :atualizacao_cadastral, foreign_key: :tatc_id
  belongs_to :tabela_coluna,         -> { includes(:tabela) }, foreign_key: :tbco_id
  belongs_to :usuario,               foreign_key: :usur_id

  scope :por_atualizacao, ->(atualizacao) { where(atualizacao_cadastral_id: atualizacao) }
  scope :com_relacionamentos, -> { includes(:tabela_coluna, :usuario, :atualizacao_cadastral) }
  scope :por_atualizacao, -> (atualizacao_cadastral_id) { where(tatc_id: atualizacao_cadastral_id) }
  scope :por_ids, -> (coluna_atualizacao_cadastral_ids) { where(tcac_id: coluna_atualizacao_cadastral_ids) }

  def revisao_com_revisado
    update_attribute(:valor_pre_aprovado, valor_revisado)
  end

  def revisao_com_transmitido
    update_attribute(:valor_pre_aprovado, valor_atual)
  end

  def self.aplicar_revisao(imovel_id, ids_colunas_revisadas = [])
    ColunaAtualizacaoCadastral.transaction do
      atualizacao_cadastral_id = AtualizacaoCadastral.find_by(codigo_imovel: imovel_id).try(:tatc_id)
      return if atualizacao_cadastral_id.nil?

      self.por_atualizacao(atualizacao_cadastral_id).por_ids(ids_colunas_revisadas).each { |coluna| coluna.revisao_com_revisado }
      if ids_colunas_revisadas.empty?
        self.por_atualizacao(atualizacao_cadastral_id).each { |coluna| coluna.revisao_com_transmitido }
      else
        self.por_atualizacao(atualizacao_cadastral_id).por_ids(ids_colunas_revisadas).each { |coluna| coluna.revisao_com_transmitido }
      end
    end
  end
end
