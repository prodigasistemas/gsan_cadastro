class ClienteRetorno < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'atualizacaocadastral.cliente_retorno'
  self.primary_key = 'clir_id'

  alias_attribute "id", "clir_id"
  alias_attribute "nome", "clir_nmcliente"
  alias_attribute "cpf", "clir_nncpf"
  alias_attribute "rg", "clir_nnrg"
  alias_attribute "cnpj", "clir_nncnpj"
  alias_attribute "email", "clir_dsemail"
  alias_attribute "ultima_alteracao", "clir_tmultimaalteracao"
  alias_attribute "pessoa_sexo_id", "psex_id"
  alias_attribute "unidade_federecao_id", "unfe_id"
  alias_attribute "cliente_tipo_id", "cltp_id"
  alias_attribute "cliente_id", "clie_id"
  alias_attribute "tipo_operacao", "clir_tipooperacao"

  belongs_to :pessoa_sexo, foreign_key: "psex_id"
  belongs_to :unidade_federacao, foreign_key: "unfe_id"
  belongs_to :cliente_tipo, foreign_key: "cltp_id"
  belongs_to :cliente, foreign_key: "clie_id"

  has_many :cliente_fone_retornos, foreign_key: "clir_id"
end