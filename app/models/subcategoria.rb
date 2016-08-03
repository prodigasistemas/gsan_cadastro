class Subcateogria < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cadastro.subcategoria'
  self.primary_key = 'scat_id'

  alias_attribute "id", "scat_id"
  alias_attribute "categoria_id", "catg_id"
  alias_attribute "codigo", "scat_cdsubcategoria"
  alias_attribute "descricao", "scat_dssubcategoria"
  alias_attribute "indicador_uso", "scat_icuso"
  alias_attribute "ultima_alteracao", "scat_tmultimaalteracao"
  alias_attribute "codigo_tarifa_social", "scat_cdtarifasocial"
  alias_attribute "fator_fiscalizacao", "scat_nnfatorfiscalizacao"
  alias_attribute "indicador_tarifa_consumo", "scat_ictarifaconsumo"
  alias_attribute "abreviacao", "scat_dsabreviada"
  alias_attribute "codigo_grupo_subcategoria", "scat_cdgruposubcategoria"
  alias_attribute "indicador_sazonalidade", "scat_icsazonalidade"
  alias_attribute "indicador_rural", "scat_icrural"
end