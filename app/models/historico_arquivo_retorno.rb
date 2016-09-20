class HistoricoArquivoRetorno < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  SITUACAO = {
    pendente: 'pendente',
    concluido: 'concluido',
    falha: 'falha'
  }

  TIPO_ARQUIVO = {
    imovel_retorno: "recadastramento_imovel",
    hidrometro_historico: "hidrometro_historico"
  }

  self.table_name  = 'atualizacaocadastral.historico_arquivo_retorno'
  self.primary_key = 'hiar_id'

  alias_attribute :id,               :hiar_id
  alias_attribute :usuario_id,       :usur_id
  alias_attribute :empresa_id,       :empr_id
  alias_attribute :criado_em,        :hiar_tmultimaalteracao
  alias_attribute :situacao_arquivo, :situacao
  alias_attribute :caminho,          :caminho_arquivo
  alias_attribute :tipo_arquivo,     :hiar_tipo_arquivo

  belongs_to :usuario, foreign_key: :usur_id
  belongs_to :empresa, foreign_key: :empr_id
end