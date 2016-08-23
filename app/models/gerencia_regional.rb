class GerenciaRegional < ActiveRecord::Base
  include IncrementableId

  self.table_name  = 'cadastro.gerencia_regional'
  self.primary_key = 'greg_id'

  alias_attribute "id",                     "greg_id"
  alias_attribute "nome",                   "greg_nmregional"
  alias_attribute "nome_abreviado",         "greg_nmabreviado"
  alias_attribute "logradouro_id",          "logr_id"
  alias_attribute "numero_imovel",          "greg_nnimovel"
  alias_attribute "descricao_complemento",  "greg_dscomplementoendereco"
  alias_attribute "endereco_referencia_id", "edrf_id"
  alias_attribute "bairro_id",              "bair_id"
  alias_attribute "cep_id",                 "cep_id"
  alias_attribute "telefone",               "greg_nnfone"
  alias_attribute "ramal",                  "greg_nnfoneramal"
  alias_attribute "fax",                    "greg_nnfax"
  alias_attribute "email",                  "greg_dsemail"
  alias_attribute "indicador_de_uso",       "greg_icuso"
  alias_attribute "ultima_alteracao",       "greg_tmultimaalteracao"
  alias_attribute "logradouro_bairro_id",   "lgbr_id"
  alias_attribute "logradouro_cep_id",      "lgcp_id"
  alias_attribute "cnpj",                   "greg_nncnpj"
  alias_attribute "superintendencia_id",    "supt_id"
end