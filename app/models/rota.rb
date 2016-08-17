class Rota < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name  = 'micromedicao.rota'
  self.primary_key = 'rota_id'

  alias_attribute "id",                  "rota_id"
  alias_attribute "setor_comercial_id",  "stcm_id"
  alias_attribute "codigo",              "rota_cdrota"
  alias_attribute "ativo",               "rota_icuso"

  belongs_to :setor_comercial, foreign_key: :stcm_id
  has_many :quadras, foreign_key: :rota_id
  has_many :imoveis, through: :quadras
  has_many :arquivo_texto_atlz_cads, foreign_key: :rota_id
  has_many :imovel_retornos, foreign_key: :rota_id

  validates :codigo, :ativo, presence: true

  scope :setor_comercial_id, -> (id) { where setor_comercial_id: id }
end