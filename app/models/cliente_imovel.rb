class ClienteImovel < ActiveRecord::Base
  include IncrementableId

  self.table_name  = 'cadastro.cliente_imovel'
  self.primary_key = 'clim_id'

  alias_attribute "id", "clim_id"
  alias_attribute "cliente_id", "clie_id"
  alias_attribute "imovel_id", "imov_id"
  alias_attribute "data_inicio_relacao", "clim_dtrelacaoinicio"
  alias_attribute "data_fim_relacao", "clim_dtrelacaofim"
  alias_attribute "motivo_fim_relacao_id", "cifr_id"
  alias_attribute "ultima_alteracao", "clim_tmultimaalteracao"
  alias_attribute "tipo_relacao", "crtp_id"
  alias_attribute "nome_conta", "clim_icnomeconta"
  alias_attribute "cliente_relacao_tipo_id", "crtp_id"

  belongs_to :imovel, foreign_key:  :imov_id
  belongs_to :cliente, foreign_key: :clie_id
  belongs_to :cliente_relacao_tipo, foreign_key: :crtp_id
end