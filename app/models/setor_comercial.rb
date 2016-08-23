class SetorComercial < ActiveRecord::Base
  include IncrementableId
  include API::Model
  include API::Filterable

  self.table_name  = 'cadastro.setor_comercial'
  self.primary_key = 'stcm_id'

  alias_attribute "id",            "stcm_id"
  alias_attribute "nome",          "stcm_nmsetorcomercial"
  alias_attribute "codigo", "stcm_cdsetorcomercial"
  alias_attribute "indicador_uso", "stcm_icuso"
  alias_attribute "municipio_id", "muni_id"
  alias_attribute "ultima_alteracao", "stcm_tmultimaalteracao"
  alias_attribute "indicador_alternativo", "stcm_icalternativo"
  alias_attribute "indicador_bloqueio", "stcm_icbloqueio"
  alias_attribute "localidade_id", "loca_id"

  belongs_to :municipio, foreign_key: :muni_id
  belongs_to :localidade, foreign_key: :loca_id
  has_many :imoveis, foreign_key: :stcm_id
  has_many :rotas,   foreign_key: :stcm_id

  scope :nome,          -> (nome) { where("UPPER(stcm_nmsetorcomercial) LIKE ?", "%#{nome.upcase}%") }
  scope :localidade_id, -> (id) { where localidade_id: id }
end