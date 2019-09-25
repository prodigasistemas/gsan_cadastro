class LigacaoEsgotoMaterial < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name = 'atendimentopublico.ligacao_esgoto_material'
  self.primary_key = 'legm_id'

  alias_attribute "id",                 "legm_id"
  alias_attribute "descricao",          "legm_dsligacaoesgotomaterial"
  alias_attribute "indicador_uso",      "legm_icuso"
  alias_attribute "ultima_alteracao",   "legm_tmultimaalteracao"

end