class ConsumoAnormalidade < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'micromedicao.consumo_anormalidade'
  self.primary_key = 'csan_id'

  alias_attribute "id",                      "csan_id"
  alias_attribute "descricao",               "csan_dsconsumoanormalidade"
end