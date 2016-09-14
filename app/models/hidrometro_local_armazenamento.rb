class HidrometroLocalArmazenamento < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'micromedicao.hidrometro_local_armaz'
  self.primary_key = 'hila_id'

  alias_attribute "", "hila_id"
  alias_attribute "", "hila_dshidrlocalarmazenagem"
  alias_attribute "", "hila_dsabrvhidmtlocalarmz"
  alias_attribute "", "hila_icuso"
  alias_attribute "", "hila_tmultimaalteracao"
  alias_attribute "", "hila_icoficina"
end