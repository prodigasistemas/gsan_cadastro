class MedicaoTipo < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'micromedicao.medicao_tipo'
  self.primary_key = 'medt_id'

  alias_attribute "id",                        "medt_id"
  alias_attribute "descricao",                 "medt_dsmedicaotipo"
  alias_attribute "indicador_uso",             "medt_icuso"
  alias_attribute "ultima_alteracao",          "medt_tmultimaalteracao"
  
end