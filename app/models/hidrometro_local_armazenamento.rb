class HidrometroLocalArmazenamento < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'micromedicao.hidrometro_local_armaz'
  self.primary_key = 'hila_id'

  alias_attribute "id", "hila_id"
  alias_attribute "descricao", "hila_dshidrlocalarmazenagem"
  alias_attribute "abreviacao", "hila_dsabrvhidmtlocalarmz"
  alias_attribute "indicador_uso", "hila_icuso"
  alias_attribute "ultima_alteracao", "hila_tmultimaalteracao"
  alias_attribute "indicador_oficina", "hila_icoficina"
end