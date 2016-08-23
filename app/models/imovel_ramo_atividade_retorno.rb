class ImovelRamoAtividadeRetorno < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'atualizacaocadastral.imovel_ramo_atividade_retorno'
  self.primary_key = 'irar_id'

  alias_attribute "id", "irar_id"
  alias_attribute "imovel_id", "imov_id"
  alias_attribute "ramo_atividade_id", "ratv_id"
  alias_attribute "imovel_retorno_id", "imre_id"
  alias_attribute "ultima_alteracao", "irar_tmultimaalteracao"

  belongs_to :imovel, foreign_key: "imov_id"
  belongs_to :ramo_atividade, foreign_key: "ratv_id"
  belongs_to :imovel_retorno, foreign_key: "imre_id"
end