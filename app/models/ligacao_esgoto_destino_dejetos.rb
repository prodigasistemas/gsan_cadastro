class LigacaoEsgotoDestinoDejetos < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name = 'atendimentopublico.lig_esgoto_dest_dejetos'
  self.primary_key = 'ledd_id'

  alias_attribute "id",                 "ledd_id"
  alias_attribute "descricao",          "ledd_dsdestinodejetos"
  alias_attribute "indicador_uso",      "ledd_icuso"
  alias_attribute "ultima_alteracao",   "ledd_tmultimaalteracao"

  
end