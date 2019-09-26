class PavimentoCalcada < ActiveRecord::Base
    include IncrementableId
    include API::Model
    include API::Filterable

    self.table_name = 'cadastro.pavimento_calcada'
    self.primary_key = 'pcal_id'

    alias_attribute "id",                    "pcal_id"
    alias_attribute "descricao",             "pcal_dspavimentocalcada"
    alias_attribute "abreviado",             "pcal_dsabreviado"
    alias_attribute "indicador_uso",         "pcal_icuso"   
end