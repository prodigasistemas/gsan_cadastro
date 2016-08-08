class ImovelSubcategoriaRetorno < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'atualizacaocadastral.imovel_subcategoria_retorno'
  self.primary_key = 'isre_id'

  alias_attribute "id", "isre_id"
  alias_attribute "imovel_id", "imov_id"
  alias_attribute "subcategoria_id", "scat_id"
  alias_attribute "quantidade_economia", "isre_qteconomia"
  alias_attribute "imovel_retorno_id", "imre_id"
  alias_attribute "ultima_alteracao", "isre_tmultimaalteracao"

  belongs_to :imovel, foreign_key: "imov_id"
  belongs_to :subcategoria, foreign_key: "scat_id"
  belongs_to :imovel_retorno, foreign_key: "imre_id"
end