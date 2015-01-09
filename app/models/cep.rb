class Cep < ActiveRecord::Base
  include IncrementableId

  self.table_name  = 'cadastro.cep'
  self.primary_key = 'cep_id'

  alias_attribute "id",         "cep_id"
  alias_attribute "codigo",     "cep_cdcep"
  alias_attribute "uf",         "cep_dsufsigla"
  alias_attribute "municipio",  "cep_nmmunicipio"
  alias_attribute "bairro",     "cep_nmbairro"

  validates_presence_of :codigo, :uf, :municipio
end
