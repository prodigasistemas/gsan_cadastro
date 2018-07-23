class Tabela < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = "seguranca.tabela"
  self.primary_key = "tabe_id"

  alias_attribute "id",               "tabe_id"
  alias_attribute "ultima_alteracao", "tabe_tmultimaalteracao"
  alias_attribute "nome",             "tabe_nmtabela"
  alias_attribute "descricao",        "tabe_dstabela"

  has_many :tabela_colunas, foreign_key: :tabe_id
end
