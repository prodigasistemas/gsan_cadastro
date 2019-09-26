class LigacaoEsgotoDiametro < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name = 'atendimentopublico.ligacao_esgoto_diametro'
  self.primary_key = 'legd_id'

  alias_attribute "id",                 "legd_id"
  alias_attribute "descricao",          "legd_dsligacaoesgotodiametro"
  alias_attribute "indicador_uso",      "legd_icuso"
  alias_attribute "ultima_alteracao",   "legd_tmultimaalteracao"

  
end
