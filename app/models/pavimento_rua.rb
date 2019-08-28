class PavimentoRua < ActiveRecord::Base
    include IncrementableId
    include API::Model
    include API::Filterable

    self.table_name = 'cadastro.pavimento_rua'
    self.primary_key = 'prua_id'

    alias_attribute "id",                    "prua_id"
    alias_attribute "descricao",             "prua_dspavimentorua"
    alias_attribute "abreviado",             "prua_dsabreviado"
    alias_attribute "indicador_uso",         "prua_icuso"   
end