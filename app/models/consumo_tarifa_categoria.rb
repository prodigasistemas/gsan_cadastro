class ConsumoTarifaCategoria < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'faturamento.consumo_tarifa'
  self.primary_key = 'cstc_id'

  alias_attribute "id", "cstc_id"
  alias_attribute "descricao", "cstf_dsconsumotarifa"
  alias_attribute "ultima_alteracao", "cstc_tmultimaalteracao"
  alias_attribute "consum_minimo", "cstc_nnconsumominimo"
  alias_attribute "valor_tarifa_minima", "cstc_vltarifaminima"
  alias_attribute "consumo_tarifa_vigencia_id", "cstv_id"
  alias_attribute "categoria_tarifa_id", "catg_id"
  alias_attribute "subcategoria_id", "scat_id"

  belongs_to  :subcategoria,              foreign_key: :subcategoria_id,            class_name: 'Subcategoria'
  belongs_to  :categoria_tarifa,          foreign_key: :categoria_tarifa_id,        class_name: 'CategoriaTarifa'
  has_many    :categoria_tarifa_vigencia, foreign_key: :consumo_tarifa_vigencia_id, class_name: 'CategoriaTarifaVigencia'
  
  delegate :subcategoria,               :to => :imovel, :allow_nil => true, :prefix => true
  delegate :categoria_tarifa,           :to => :imovel, :allow_nil => true, :prefix => true
  delegate :categoria_tarifa_vigencia,  :to => :imovel, :allow_nil => true, :prefix => true
end