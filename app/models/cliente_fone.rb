class ClienteFone < ActiveRecord::Base
  include IncrementableId

  self.table_name  = 'cadastro.cliente_fone'
  self.primary_key = 'cfon_id'

  alias_attribute "id",            "cfon_id"                # integer NOT NULL, -- Id do cliente_fone (Sequencial)
  alias_attribute "cliente_id",    "clie_id"                # integer NOT NULL, -- Id do Cliente
  alias_attribute "ddd",           "cfon_cdddd"             # character(2), -- Codigo do DDD do Telefone
  alias_attribute "numero",        "cfon_nnfone"            # character varying(9), -- Numero do Telefone
  alias_attribute "ramal",         "cfon_nnfoneramal"       # character varying(4), -- Numero do Ramal
  alias_attribute "padrao",        "cfon_icfonepadrao"      # smallint, -- Indicador de Telefone Padrao (1_Sim; 2_Nao). Um e somente um Telefone do Cliente deve ter o Indicador igual a 1_Sim.
  alias_attribute "fone_tipo_id",  "fnet_id"                # integer NOT NULL, -- Id do Tipo de Telefone
  alias_attribute "atualizado_em", "cfon_tmultimaalteracao" # timestamp without time zone NOT NULL DEFAULT now(), -- Timestamp
  alias_attribute "nome_contato",  "cfon_nmcontato"         # character varying(50), -- Nome do Contato

  belongs_to :cliente,    foreign_key: :clie_id, inverse_of: :telefones
  belongs_to :fone_tipo,  foreign_key: :fnet_id

  validate :valida_telefone_padrao

  private

  def valida_telefone_padrao
    atual_fone_padrao = cliente.telefones.select { |e| e.padrao.to_i == 1 }.first
    errors.add(:padrao, :taken) if atual_fone_padrao &&
                                    self.padrao.to_i == 1 &&
                                    atual_fone_padrao != self
  end
end
