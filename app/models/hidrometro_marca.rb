class HidrometroMarca < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'micromedicao.hidrometro_marca'
  self.primary_key = 'himc_id'

  alias_attribute "id", "himc_id"
  alias_attribute "descricao", "himc_dshidrometromarca"
  alias_attribute "abreviacao", "himc_dsabreviadahidrmarca"
  alias_attribute "dia_revisao", "himc_nndiarevisao"
  alias_attribute "indicador_uso", "himc_icuso"
  alias_attribute "ultima_alteracao", "himc_tmultimaalteracao"
  alias_attribute "codigo", "himc_cdhidrometromarca"
  alias_attribute "indicador_micro", "himc_icmicro"
  alias_attribute "indicador_macro", "himc_icmacro"
end