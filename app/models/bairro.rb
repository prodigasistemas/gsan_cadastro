class Bairro < ActiveRecord::Base
  include IncrementableId

  self.table_name  = "cadastro.bairro"
  self.primary_key = "bair_id"

  alias_attribute "id",                 "bair_id"
  alias_attribute "municipio_id",       "muni_id"
  alias_attribute "codigo",             "bair_cdbairro"
  alias_attribute "nome",               "bair_nmbairro"
  alias_attribute "codigo_prefeitura",  "bair_cdbairroprefeitura"
  alias_attribute "ativo",              "bair_icuso"
  alias_attribute "atualizado_em",      "bair_tmultimaalteracao"

  default_scope -> { order(:nome) }

  def self.pesquisar(query = nil)
    if query
      where(query)
    else
      all
    end
  end
end
