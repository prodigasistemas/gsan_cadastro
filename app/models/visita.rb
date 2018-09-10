class Visita < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = 'atualizacaocadastral.visita'
  self.primary_key = 'vist_id'

  alias_attribute "id",                                       "vist_id"
  alias_attribute "imovel_controle_atualizacao_cadastral_id", "icac_id"
  alias_attribute "cadastro_ocorrencia_id",                   "cocr_id"
  alias_attribute "atualizado_em",                            "vist_tmultimaalteracao"
  alias_attribute "coordenada_x",                             "vist_nncoordenadax"
  alias_attribute "coordenada_y",                             "vist_nncoordenaday"

  belongs_to :imovel_controle_atualizacao_cadastral, foreign_key: :icac_id
  belongs_to :cadastro_ocorrencia, foreign_key: :cocr_id
end
