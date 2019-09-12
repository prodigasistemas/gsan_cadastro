class ImovelRamoAtividade < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cadastro.imovel_ramo_atividade'

  alias_attribute "ultima_alteracao",           "imra_tmultimaalteracao"
  alias_attribute "imov_id",                    "imov_id"
  alias_attribute "ratv_id",                    "ratv_id"

  belongs_to  :ramo_atividade,  foreign_key: :ratv_id,  class_name: 'RamoAtividade'
  belongs_to  :imovel,          foreign_key: :imov_id,  class_name: 'Imovel'
  
  delegate :ramo_atividade,     :to => :imovel, :allow_nil => true, :prefix => true
end