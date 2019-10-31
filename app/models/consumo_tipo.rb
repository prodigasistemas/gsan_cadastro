class ConsumoTipo < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'micromedicao.consumo_tipo'
  self.primary_key = 'cstp_id'

  alias_attribute "id",                      "cstp_id"
  alias_attribute "descricao",               "cstp_dsconsumotipo"
  alias_attribute "descricao_abreviada",     "cstp_dsabreviadaconsumotipo"
end