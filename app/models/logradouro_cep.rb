class LogradouroCep < ActiveRecord::Base
  include IncrementableId

  self.table_name  = 'cadastro.logradouro_cep'
  self.primary_key = 'lgcp_id'

  alias_attribute "id",            "lgcp_id"
  alias_attribute "logradouro_id", "logr_id"
  alias_attribute "ativo",         "lgcp_icuso"
  alias_attribute "atualizado_em", "lgcp_tmultimaalteracao"

  has_many :imoveis,            class_name: "Imovel",           foreign_key: :lgcp_id
  has_many :cliente_enderecos,  class_name: "ClienteEndereco",  foreign_key: :lgcp_id
  belongs_to :logradouro, foreign_key: :logr_id, inverse_of: :logradouro_ceps
  belongs_to :cep, foreign_key: :cep_id, inverse_of: :logradouro_ceps

  before_destroy :valida_nenhum_imovel_relacionado
  before_destroy :valida_nenhum_cliente_enderecos_relacionado
  validates_inclusion_of :ativo, in: [1,2]

  private

  def valida_nenhum_imovel_relacionado
    if self.imoveis.present?
      errors.add(:imoveis, :are_present)
      throw :abort
    end
  end

  def valida_nenhum_cliente_enderecos_relacionado
    if self.cliente_enderecos.present?
      errors.add(:cliente_enderecos, :are_present)
      throw :abort
    end
  end
end
