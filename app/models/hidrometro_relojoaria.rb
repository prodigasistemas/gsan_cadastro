class HidrometroRelojoaria < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'micromedicao.hidrometro_relojoaria'
  self.primary_key = 'hire_id'

  alias_attribute "id",                        "hire_id"
  alias_attribute "descricao",                 "hire_dsrelojoaria"
  alias_attribute "indicador_uso",             "hire_icuso"
  alias_attribute "ultima_alteracao",          "hire_tmultimaalteracao"
  
end