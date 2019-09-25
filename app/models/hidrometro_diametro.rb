class HidrometroDiametro < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'micromedicao.hidrometro_diametro'
  self.primary_key = 'hidm_id'

  alias_attribute "id",                        "hidm_id"
  alias_attribute "descricao",                 "hidm_dshidrometrodiametro"
  alias_attribute 'descricao_abreviada',       "hidm_dcabreviadahidrometrodiametro"
  alias_attribute "indicador_uso",             "hidm_icuso"
  alias_attribute "ultima_alteracao",          "hidm_tmultimaalteracao"
  alias_attribute "numero_ordem",              "hidm_nnordem"
  
end