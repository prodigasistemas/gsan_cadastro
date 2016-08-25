class Acao < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cadastro.acoes_desempenho_performance'
  self.primary_key = 'acdp_id'

  alias_attribute "id", "acdp_id"
  alias_attribute "titulo", "acdp_titulo"
  alias_attribute "descricao", "acdp_descricao"
  alias_attribute "data_criacao", "acdp_tmcriacao"
  alias_attribute "data_atualizacao", "acdp_tmultimaalteracao"
  alias_attribute "contrato_medicao_id", "cmed_id"

  belongs_to :contrato_medicao, foreign_key: 'cmed_id'
end