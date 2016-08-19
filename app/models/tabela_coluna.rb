class TabelaColuna < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name  = 'seguranca.table_coluna'
  self.primary_key = 'tbco_id'

  alias_attribute :nome_coluna, :tbco_nmcoluna
end