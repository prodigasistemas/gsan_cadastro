class Coeficiente < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name  = 'cadastro.contrato_medicao_coeficiente'
  self.primary_key = 'cmco_id'

  alias_attribute "id",                   "cmco_id"
  alias_attribute "coeficiente",          "cmco_coeficiente"
  alias_attribute "contrato_medicao_id",  "cmed_id"
  alias_attribute "ligacao_agua_id",  "last_id"

  belongs_to :contrato_medicao, foreign_key: 'cmed_id'
  belongs_to :ligacao_agua_situacao, foreign_key: 'last_id'

  validates :coeficiente, :ligacao_agua_id , presence: true

  def atributos(referencia=nil)
    super([:contrato_medicao, :ligacao_agua_situacao], referencia)
  end
end