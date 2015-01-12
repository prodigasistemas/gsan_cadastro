class Cep < ActiveRecord::Base
  include IncrementableId

  self.table_name  = 'cadastro.cep'
  self.primary_key = 'cep_id'

  alias_attribute "id",               "cep_id"
  alias_attribute "codigo",           "cep_cdcep"
  alias_attribute "uf",               "cep_dsufsigla"
  alias_attribute "municipio",        "cep_nmmunicipio"
  alias_attribute "bairro",           "cep_nmbairro"
  alias_attribute "tipo_id",          "cept_id"
  alias_attribute "ativo",            "cep_icuso"
  alias_attribute "tipo_logradouro",  "cep_dslogradourotipo"
  alias_attribute "logradouro",       "cep_nmlogradouro"
  alias_attribute "atualizado_em",    "cep_tmultimaalteracao"
  alias_attribute "intervalo",        "cep_dsintervalonumeracao"


  belongs_to :cep_tipo, foreign_key: :cept_id
end
