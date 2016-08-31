class ClienteImovelRetorno < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'atualizacaocadastral.cliente_imovel_retorno'
  self.primary_key = 'cire_id'

  alias_attribute "id", "cire_id"
  alias_attribute "ultima_alteracao", "clir_tmultimaalteracao"
  alias_attribute "imovel_id", "imov_id"
  alias_attribute "cliente_id", "clie_id"
  alias_attribute "cliente_relacao_tipo_id", "crtp_id"
  alias_attribute "imovel_retorno_id", "imre_id"
  alias_attribute "cliente_retorno_id", "clir_id"

  belongs_to :imovel, foreign_key: "imov_id"
  belongs_to :cliente, foreign_key: "clie_id"
  belongs_to :cliente_relacao_tipo, foreign_key: "crtp_id"
  belongs_to :imovel_retorno, foreign_key: "imre_id"
  belongs_to :cliente_retorno, foreign_key: "clir_id"

  scope :usuario, -> { where(crtp_id: 2) }
  scope :proprietario, -> { where(crtp_id: 1) }
  scope :responsavel, -> { where(crtp_id: 3) }
end