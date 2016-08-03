class HidrometroProtecao < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'micromedicao.hidrometro_protecao'
  self.primary_key = 'hipr_id'

  alias_attribute "id", "hipr_id"
  alias_attribute "descricao", "hipr_dshidrometroprotecao"
  alias_attribute "abreviacao", "hipr_dsabrvhidmtprotecao"
  alias_attribute "indicador_uso", "hipr_icuso"
  alias_attribute "ultima_alteracao", "hipr_tmultimaalteracao"
end