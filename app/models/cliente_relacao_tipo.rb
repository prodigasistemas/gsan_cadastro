class ClienteRelacaoTipo < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cadastro.cliente_relacao_tipo'
  self.primary_key = 'crtp_id'

  alias_attribute "id", "crtp_id"
  alias_attribute "descricao", "crtp_dsclienterelacaotipo"
  alias_attribute "indicador_uso", "crtp_icuso"
  alias_attribute "ultima_alteracao", "crtp_tmultimaalteracao"
end