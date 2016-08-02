class HistoricoCoeficiente < ActiveRecord::Base
  include IncrementableId
  include API::Model
  include ConvertDecimalAttributes

  self.table_name  = 'cadastro.contrato_medicao_coeficiente_historico'
  self.primary_key = 'cmcoh_id'

  alias_attribute "id",                 "cmcoh_id"
  alias_attribute "coeficiente_id",     "cmco_id"
  alias_attribute "numero_coeficiente", "cmcoh_coeficiente"
  alias_attribute "usuario_id",         "usur_id"
  alias_attribute "ligacao_agua_id",    "last_id"
  alias_attribute "criado_em",          "cmcoh_tmcriacao"

  belongs_to :coeficiente, foreign_key: 'cmco_id'
  belongs_to :ligacao_agua_situacao, foreign_key: 'last_id'
  belongs_to :usuario, foreign_key: 'usur_id'

  validates :coeficiente_id, :usuario_id, :ligacao_agua_id, :numero_coeficiente, presence: true
end