class HistoricoAbrangencia < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name  = 'desempenho.contrato_medicao_abrangencia_historico'
  self.primary_key = 'cmah_id'

  alias_attribute "id",                  "cmah_id"
  alias_attribute "criado_em",           "cmab_tmcriacao"
  alias_attribute "removido_em",         "cmab_tmremocao"
  alias_attribute "contrato_medicao_id", "cmed_id"
  alias_attribute "imovel_id",           "imov_id"

  belongs_to :contrato_medicao, foreign_key: 'cmed_id'
  belongs_to :imovel,           foreign_key: 'imov_id'
end