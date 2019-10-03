class LeituraSituacao < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name = 'micromedicao.leitura_situacao'
  self.primary_key = 'ltst_id'

  alias_attribute "id", "ltst_id"
  alias_attribute "descricao", "ltst_dsleiturasituacao"
  alias_attribute "indicador_uso", "ltst_icuso"
  alias_attribute "ultima_alteracao", "ltst_tmultimaalteracao"
  
end