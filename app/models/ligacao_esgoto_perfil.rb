class LigacaoEsgotoPerfil < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name = 'atendimentopublico.ligacao_esgoto_perfil'
  self.primary_key = 'lepf_id'

  alias_attribute "id",                 "lepf_id"
  alias_attribute "descricao",          "lepf_dsligacaoesgotoperfil"
  alias_attribute "indicador_uso",      "lepf_icuso"
  alias_attribute "ultima_alteracao",   "lepf_tmultimaalteracao"
  alias_attribute "percentual_esgoto_consumida_coletada", "lepf_pcesgoto"
  alias_attribute "indicador_principal", "lepf_icprincipal"
end