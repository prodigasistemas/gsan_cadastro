class Parametro < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'seguranca.parametro'
  self.primary_key = 'id'

  def self.url_portal
    find_by_nome("URL_SEGURANCA").valor
  end
end