class PocoTipo < ActiveRecord::Base
    include IncrementableId
    include API::Model
    include API::Filterable

    self.table_name = 'cadastro.poco_tipo'
    self.primary_key = 'poco_id'

    alias_attribute "id",                    "poco_id"
    alias_attribute "descricao",             "poco_dspocotipo"
    alias_attribute "indicador_hidrometro",  "poco_ichidrometro"
    alias_attribute "indicador_uso",         "poco_icuso"   
end