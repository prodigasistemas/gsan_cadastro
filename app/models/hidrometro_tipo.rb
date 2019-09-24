class HidrometroTipo < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'micromedicao.hidrometro_tipo'
  self.primary_key = 'hitp_id'

  alias_attribute "id",                        "hitp_id"
  alias_attribute "descricao",                 "hitp_dshidrometrotipo"
  alias_attribute 'descricao_abreviada',        "hitp_dcabreviadahidrometrotipo"
  alias_attribute "indicador_uso",             "hitp_icuso"
  alias_attribute "ultima_alteracao",          "hitp_tmultimaalteracao"
  
end