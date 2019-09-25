class LigacaoEsgotoEsgotamento < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name = 'atendimentopublico.lig_esgoto_esgotamento'
  self.primary_key = 'lees_id'

  alias_attribute "id",                 "lees_id"
  alias_attribute "descricao",          "lees_dsesgotamento"
  alias_attribute "indicador_uso",      "lees_icuso"
  alias_attribute "ultima_alteracao",   "lees_tmultimaalteracao"

end