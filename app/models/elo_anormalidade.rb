class EloAnormalidade < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cadastro.elo_anormalidade'
  self.primary_key = 'eanm_id'

  alias_attribute "id",                 "eanm_id"
  alias_attribute "descricao",          "eanm_dseloanormalidade"
  alias_attribute "indicador_uso",      "eanm_icuso"
  alias_attribute "ultima_alteracao",   "eanm_tmultimaalteracao"
  alias_attribute "suspende_contrato",  "eanm_icsuspendecontratodemanda"
end