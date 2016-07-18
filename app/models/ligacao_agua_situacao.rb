class LigacaoAguaSituacao < ActiveRecord::Base
  include IncrementableId

  self.table_name = 'atendimentopublico.ligacao_agua_situacao'
  self.primary_key = 'last_id'

  alias_attribute "id",                 "last_id"
  alias_attribute "descricao",          "last_dsligacaoaguasituacao"
  alias_attribute "indicador_uso",      "last_icuso"
  alias_attribute "ultima_alteracao",   "last_tmultimaalteracao"

  def attributes
    {
      id: id,
      descricao: descricao
    }
  end
end
