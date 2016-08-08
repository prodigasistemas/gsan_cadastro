class FonteAbastecimento < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cadastro.fonte_abastecimento'
  self.primary_key = 'ftab_id'

  alias_attribute "id", "ftab_id"
  alias_attribute "descricao", "ftab_dsfonteabastecimento"
  alias_attribute "abreviacao", "ftab_dsabreviado"
  alias_attribute "indicador_uso", "ftab_icuso"
  alias_attribute "ultima_alteracao", "ftab_tmultimaalteracao"
  alias_attribute "volume_fixo", "ftab_iccalcularvolumefixo"
  alias_attribute "permite_poco", "ftab_icpermitepoco"
end