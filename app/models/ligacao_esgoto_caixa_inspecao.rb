class LigacaoEsgotoCaixaInspecao < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name = 'atendimentopublico.lig_esgoto_caixa_inspec'
  self.primary_key = 'leci_id'

  alias_attribute "id",                 "leci_id"
  alias_attribute "descricao",          "leci_dscaixainspecao"
  alias_attribute "indicador_uso",      "leci_icuso"
  alias_attribute "ultima_alteracao",   "leci_tmultimaalteracao"

end