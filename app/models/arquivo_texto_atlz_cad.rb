class ArquivoTextoAtlzCad < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cadastro.arquivo_texto_atlz_cad'
  self.primary_key = 'txac_id'

  alias_attribute :id, 												:txac_id
  alias_attribute :localidade_id, 						:loca_id
  alias_attribute :setor_comercial_codigo,		:txac_cdsetorcomercial

  belongs_to :leiturista,   foreign_key: :leit_id
  belongs_to :rota,         foreign_key: :rota_id
  
  has_many :imovel_retornos, through: :rota, foreign_key: :rota_id
end