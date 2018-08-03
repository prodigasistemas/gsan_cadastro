class LocalidadeClasse <  ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cadastro.localidade_classe'
  self.primary_key = 'lcla_id'

  alias_attribute "id", "lcla_id"
  alias_attribute "descricao", "lcla_dslocalidadeclasse"
  alias_attribute "indicador_uso", "lcla_icuso"
  alias_attribute "ultima_alteracao", "lcla_tmultimaalteracao"
end
