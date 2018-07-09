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
  alias_attribute :valor_atual,              :tcac_cnvaloratual
  alias_attribute :autorizado,               :tcac_icautorizado
  alias_attribute :data_processamento,       :tcac_dtvalidacao
  alias_attribute :data_ultima_atualizacao,  :tcac_ultimaatualizacao
  alias_attribute :usuario_id,               :usur_id

  belongs_to :atualizacao_cadastral, foreign_key: :tatc_id
  belongs_to :tabela_coluna,         foreign_key: :tbco_id
  belongs_to :usuario,               foreign_key: :usur_id
end
