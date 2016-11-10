class LigacaoAguaSituacao < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name = 'atendimentopublico.ligacao_agua_situacao'
  self.primary_key = 'last_id'

  alias_attribute "id",                 "last_id"
  alias_attribute "descricao",          "last_dsligacaoaguasituacao"
  alias_attribute "indicador_uso",      "last_icuso"
  alias_attribute "ultima_alteracao",   "last_tmultimaalteracao"

  has_many :coeficientes, foreign_key: "last_id"

  SITUACAO = {
    potencial:       1,
    factivel:        2,
    ligado:          3,
    em_fiscalizacao: 4,
    cortado:         5,
    suprimido:       6
  }
end
