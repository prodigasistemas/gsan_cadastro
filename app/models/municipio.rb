class Municipio < ActiveRecord::Base
  include IncrementableId

  self.table_name  = 'cadastro.municipio'
  self.primary_key = 'muni_id'

  alias_attribute "id",               "muni_id"
  alias_attribute "nome",             "muni_nmmunicipio"
  alias_attribute "cep_inicial",      "muni_cdcepinicio"
  alias_attribute "cep_final",        "muni_cdcepfim"
  alias_attribute "ddd",              "muni_cdddd"
  alias_attribute "regiao_id",        "rdes_id"
  alias_attribute "micro_regiao_id",  "mreg_id"
  alias_attribute "uf_id",            "unfe_id"
  alias_attribute "ativo",            "muni_icuso"
  alias_attribute "atualizado_em",    "muni_tmultimaalteracao"
  alias_attribute "inicio_concessao", "muni_dtconcessaoinicio"
  alias_attribute "fim_concessao",    "muni_dtconcessaofim"
  alias_attribute "codigo_ibge",      "muni_cdibge"
  alias_attribute "quadro_bairro",    "muni_icrelacionquadrabairro"

  default_scope -> { order(:nome) }
end
