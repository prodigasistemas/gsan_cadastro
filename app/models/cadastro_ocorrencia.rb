class CadastroOcorrencia <  ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cadastro.cadastro_ocorrencia'
  self.primary_key = 'cocr_id'

  alias_attribute "id", "cocr_id"
  alias_attribute "descricao", "cocr_dscadastroocorrencia"
  alias_attribute "indicador_uso", "cocr_icuso"
  alias_attribute "ultima_alteracao", "cocr_tmultimaalteracao"
  alias_attribute "indicador_suspende_contrato", "cocr_icsuspendecontratodemanda"
  alias_attribute "indicador_validacao", "cocr_icvalidacao"
end