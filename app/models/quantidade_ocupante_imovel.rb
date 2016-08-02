class QuantidadeOcupanteImovel < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = 'cadastro.imovel_tipo_ocupante_quantidade'
  self.primary_key = 'itpq_id'

  alias_attribute "id",            "itpq_id"
  alias_attribute "quantidade",    "itpq_quantidade"

  belongs_to :imovel,        foreign_key: "imov_id"
  belongs_to :tipo_ocupante, foreign_key: "itpo_id"
end