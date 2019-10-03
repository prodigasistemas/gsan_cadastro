class LeituraAnormalidade < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name = 'micromedicao.leitura_anormalidade'
  self.primary_key = 'ltan_id'

  alias_attribute "id", "ltan_id"
  alias_attribute "descricao", "ltan_dsleituraanormalidade"
  
end