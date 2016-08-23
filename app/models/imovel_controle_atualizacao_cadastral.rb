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

  belongs_to :imovel, foreign_key: "imov_id"
  belongs_to :imovel_retorno, foreign_key: "imre_id"
  belongs_to :situacao_atualizacao_cadastral, foreign_key: "siac_id"
end