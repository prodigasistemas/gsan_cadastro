class LigacaoEsgotoDestinoAguasPluviais < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name = 'atendimentopublico.lig_esgoto_dest_agplv'
  self.primary_key = 'leda_id'

  alias_attribute "id",                 "leda_id"
  alias_attribute "descricao",          "leda_dsaguaspluviais"
  alias_attribute "indicador_uso",      "leda_icuso"
  alias_attribute "ultima_alteracao",   "leda_tmultimaalteracao"

end