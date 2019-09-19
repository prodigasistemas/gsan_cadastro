class ConsumoTarifaVigencia < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model
  
  self.table_name  = 'faturamento.consumo_tarifa'
  self.primary_key = 'cstv_id'

  alias_attribute "id", "cstv_id"
  alias_attribute "data_vigencia", "cstv_dtvigencia"
  alias_attribute "ultima_alteracao", "cstv_tmultimaalteracao"
  alias_attribute "valor_tarifa_minima", "cstc_vltarifaminima"
  alias_attribute "consumo_tarifa_id", "cstf_id"

  belongs_to  :consumo_tarifa,  foreign_key: :consumo_tarifa_id,  class_name: 'ConsumoTarifa'
  
  delegate :consumo_tarifa,     :to => :imovel, :allow_nil => true, :prefix => true
end