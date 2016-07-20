class ContratoMedicao < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = "cadastro.contrato_medicao"
  self.primary_key = "cmed_id"

  alias_attribute "id",                 "cmed_id"
  alias_attribute "numero",             "cmed_numero_contrato"
  alias_attribute "vigencia_inicial",   "cmed_vigencia_inicial"
  alias_attribute "vigencia_final",     "cmed_vigencia_final"
  alias_attribute "data_assinatura",    "cmed_data_assinatura"
  alias_attribute "empresa_id",         "empr_id"
  alias_attribute "atualizado_em",      "cmed_tmultimaalteracao"

  belongs_to :empresa, foreign_key: "empr_id"
  has_many :coeficientes, foreign_key: "cmed_id"
  has_many :abrangencias, foreign_key: "cmed_id"
  has_many :imoveis, through: :abrangencias

  validates :numero, :vigencia_inicial, :empresa_id, presence: true
  validates :numero, uniqueness: true

  def atributos
    super([:empresa])
  end
end