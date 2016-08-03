class RamalLocalInstalacao < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'atendimentopublico.ramal_local_instalacao'
  self.primary_key = 'rlin_id'

  alias_attribute "id", "rlin_id"
  alias_attribute "descricao", "rlin_dsramallocalinstalcao"
  alias_attribute "abreviado", "rlin_dsabreviado"
  alias_attribute "indicador_uso", "rlin_icuso"
  alias_attribute "ultima_alteracao", "rlin_tmultimaalteracao"
end