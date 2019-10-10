class LigacaoTipo < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name = 'micromedicao.ligacao_tipo'
  self.primary_key = 'lgti_id'

  alias_attribute "id", "lgti_id"
  alias_attribute "descricao", "lgti_dsligacaotipo"
  alias_attribute "indicador_uso", "lgti_icuso"
  alias_attribute "ultima_alteracao", "lgti_tmultimaalteracao"

  MODELO = {
    :AGUA    => 1,
    :ESGOTO  => 2
  }
end