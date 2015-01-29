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

  validates_presence_of :ddd, :numero, :cliente, :fone_tipo
  validate              :valida_telefone_padrao
  validates_length_of   :ddd, maximum: 2
  validates_length_of   :numero, maximum: 9
  validates_length_of   :ramal, maximum: 4
  validates_length_of   :nome_contato, maximum: 50

  private

  def valida_telefone_padrao
    atual_fone_padrao = cliente.telefones.select do
      |e| e.padrao.to_i == 1 
    end.first if cliente.present?
    
    errors.add(:padrao, :taken) if atual_fone_padrao &&
                                    self.padrao.to_i == 1 &&
                                    atual_fone_padrao != self
  end
end
