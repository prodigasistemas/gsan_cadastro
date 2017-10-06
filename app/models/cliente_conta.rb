class ClienteConta < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cadastro.cliente_conta'
  self.primary_key = 'clct_id'

  alias_attribute :id,                   :clct_id
  alias_attribute :cliente_id,           :clie_id
  alias_attribute :conta_id,             :cnta_id
  alias_attribute :tipo_relacao,         :crtp_id
  alias_attribute :nome_conta,           :clct_icnomeconta
  alias_attribute :ultima_alteracao,     :clct_tmultimaalteracao

  belongs_to :cliente,    foreign_key: :clie_id
  belongs_to :conta,      foreign_key: :cnta_id
end
