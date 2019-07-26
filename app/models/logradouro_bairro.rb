class LogradouroBairro < ActiveRecord::Base
  include IncrementableId

  self.table_name  = 'cadastro.logradouro_bairro'
  self.primary_key = 'lgbr_id'

  alias_attribute "id",            "lgbr_id"
  alias_attribute "logradouro_id", "logr_id"
  alias_attribute "bairro_id",     "bair_id"
  alias_attribute "atualizado_em", "lgbr_tmultimaalteracao"

  has_many :imoveis,            class_name: "Imovel",           foreign_key: :lgbr_id
  has_many :cliente_enderecos,  class_name: "ClienteEndereco",  foreign_key: :lgbr_id
  belongs_to :logradouro, foreign_key: :logr_id
  belongs_to :bairro, foreign_key: :bair_id

  before_destroy :valida_nenhum_imovel_relacionado
  before_destroy :valida_nenhum_cliente_endereco_relacionado

  private

  def valida_nenhum_imovel_relacionado
    if self.imoveis.present?
      errors.add(:imoveis, :are_present)
      throw :abort
    end
  end

  def valida_nenhum_cliente_endereco_relacionado
    if self.cliente_enderecos.present?
      errors.add(:cliente_enderecos, :are_present)
      throw :abort
    end
  end
end
