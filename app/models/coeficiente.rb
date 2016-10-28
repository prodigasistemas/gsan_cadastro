class Coeficiente < ActiveRecord::Base
  include IncrementableId
  include API::Model
  include ConvertDecimalAttributes

  attr_accessor :usuario_id

  self.table_name  = 'desempenho.contrato_medicao_coeficiente'
  self.primary_key = 'cmco_id'

  alias_attribute "id",                   "cmco_id"
  alias_attribute "coeficiente",          "cmco_coeficiente"
  alias_attribute "contrato_medicao_id",  "cmed_id"
  alias_attribute "ligacao_agua_id",  "last_id"

  belongs_to :contrato_medicao, foreign_key: 'cmed_id'
  belongs_to :ligacao_agua_situacao, foreign_key: 'last_id'
  has_many   :historico_coeficientes, foreign_key: 'cmco_id'

  convert_decimal :cmco_coeficiente

  validates :coeficiente, :ligacao_agua_id , presence: true
  validates :contrato_medicao_id, uniqueness: { scope: :last_id }
  validates :coeficiente, numericality: true

  after_save :salvar_historico

  private

  def salvar_historico
    HistoricoCoeficiente.create(
                            coeficiente_id: self.id,
                            numero_coeficiente: self.coeficiente,
                            usuario_id: self.usuario_id,
                            ligacao_agua_id: self.ligacao_agua_id
                          )
  end
end