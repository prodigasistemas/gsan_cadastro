class Grupo < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'seguranca.grupo'
  self.primary_key = 'grup_id'

  alias_attribute :id,                 :grup_id
  alias_attribute :descricao,          :grup_dsgrupo
  alias_attribute :descricao_abreviada, :grup_dsabreviado

  has_many :usuario_grupos, foreign_key: :grup_id
end