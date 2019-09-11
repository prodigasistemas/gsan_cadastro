class ImovelEloAnormalidade < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cadastro.imovel_elo_anormalidade'
  self.primary_key = 'iean_id'

  alias_attribute "id",                         "iean_id"
  alias_attribute "data_anormalidade",          "iean_dtanormalidadeelo"
  alias_attribute "foto_anormalidade",          "iean_fotoanormalidadeelo"
  alias_attribute "ultima_alteracao",           "iean_tmultimaalteracao"
  alias_attribute "imov_id",                    "imov_id"
  alias_attribute "eanm_id",                    "eanm_id"
  
  belongs_to  :elo_anormalidade,          foreign_key: :clie_idescritorio,  class_name: 'EloAnormalidade'
  delegate :elo_anormalidade,  :to => :imovel, :allow_nil => true, :prefix => true
end