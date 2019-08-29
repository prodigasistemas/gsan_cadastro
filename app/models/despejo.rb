class Despejo < ActiveRecord::Base
    include IncrementableId
    include API::Model
    include API::Filterable

    self.table_name = 'cadastro.despejo'
    self.primary_key = 'depj_id'

    alias_attribute "id",                    "depj_id"
    alias_attribute "descricao",             "depj_dsdespejo"
    alias_attribute "abreviado",             "depj_dsabreviado"
    alias_attribute "indicador_uso",         "depj_icuso"   
end
  