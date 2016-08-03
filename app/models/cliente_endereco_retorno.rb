class ClienteEnderecoRetorno < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'atualizacaocadastral.cliente_endereco_retorno'
  self.primary_key = 'cler_id'

  alias_attribute "id", "cler_id"
  alias_attribute "numero_imovel", "cler_nnimovel"
  alias_attribute "complemento_endereco", "cler_dscomplementoendereco"
  alias_attribute "ultima_alteracao", "cler_tmultimaalteracao"
  alias_attribute "nome_municipio", "cler_nmmunicipio"
  alias_attribute "nome_bairro", "cler_nmbairro"
  alias_attribute "descricao_logradouro", "cler_dslogradouro"
  alias_attribute "codigo_cep", "cler_cdcep"
  alias_attribute "endereco_tipo_id", "edtp_id"
  alias_attribute "cliente_id", "clie_id"
  alias_attribute "cliente_retorno_id", "clir_id"
  alias_attribute "logradouro_tipo_id", "lgtp_id"

  belongs_to :cliente, foreign_key: "clie_id"
  belongs_to :cliente_retorno, foreign_key: "clir_id"
  belongs_to :logradouro_tipo, foreign_key: "lgtp_id"
  belongs_to :endereco_tipo, foreign_key: "edtp_id"
end