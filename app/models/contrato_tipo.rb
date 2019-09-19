class ContratoTipo < ActiveRecord::Base
  include IncrementableId
    include API::Filterable
    include API::Model
  
    self.table_name  = 'faturamento.consumo_tarifa'
    self.primary_key = 'cttp_id'
  
    alias_attribute "id", "cttp_id"
    alias_attribute "descricao", "cttp_dscontratotipo"
    alias_attribute "ultima_alteracao", "cttp_tmultimaalteracao"
    alias_attribute "indicador_uso", "cttp_icuso"
end