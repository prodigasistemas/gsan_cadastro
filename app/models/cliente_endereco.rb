class ClienteEndereco < ActiveRecord::Base
  include IncrementableId
  self.table_name  = 'cadastro.cliente_endereco'
  self.primary_key = 'cled_id'

  alias_attribute "id",                   "cled_id"                         # integer NOT NULL, -- Id do cliente_endereco (Sequencial)
  alias_attribute "cliente_id",           "clie_id"                         # integer NOT NULL, -- Id do Cliente
  alias_attribute "endereco_tipo_id",     "edtp_id"                         # integer NOT NULL, -- Id do Tipo de Endereco
  alias_attribute "logradouro_id",        "logr_id"                         # integer, -- Id do Logradouro
  alias_attribute "logradouro_bairro_id", "lgbr_id"                         # integer, -- id do logradouro_bairro
  alias_attribute "logradouro_cep_id",    "lgcp_id"                         # integer, -- id do logradouro_cep
  alias_attribute "perimetro_inicial_id", "logr_idinicioperimetro"          # integer, -- Id do logradouro do inicio do perímetro
  alias_attribute "perimetro_final_id",   "logr_idfimperimetro"             # integer, -- Id do logradouro do final do perimetro
  alias_attribute "referencia_id",        "edrf_id"                         # integer, -- Id da Referencia do Numero do Imovel
  # alias_attribute "cep_id",               "cep_id"                          # integer, -- Id do CEP do Endereco
  alias_attribute "bairro_id",            "bair_id"                         # integer, -- Id do Bairro
  alias_attribute "numero",               "cled_nnimovel"                   # character(5), -- Numero do Imovel
  alias_attribute "complemento",          "cled_dscomplementoendereco"      # character varying(25), -- Complemento do Endereco
  alias_attribute "correspondencia",      "cled_icenderecocorrespondencia"  # smallint, -- Indicador de Endereco de Correspondencia (1_Sim; 2_Nao). Um e somente um Endereco do Cliente deve ter o Indicador igual a 1_Sim.
  alias_attribute "atualizado_em",        "cled_tmultimaalteracao"          # timestamp without time zone NOT NULL DEFAULT now(), -- timestamp da inclusao/ultima alteracao

  belongs_to :referencia,         foreign_key: "edrf_id", class_name: "EnderecoReferencia"
  belongs_to :endereco_tipo,      foreign_key: "edtp_id" , class_name: "EnderecoTipo"
  belongs_to :logradouro,         foreign_key: "logr_id"
  belongs_to :logradouro_cep,     foreign_key: "lgcp_id"
  belongs_to :logradouro_bairro,  foreign_key: "lgbr_id"
  belongs_to :perimetro_inicial,  foreign_key: "logr_idinicioperimetro", class_name: "Logradouro"
  belongs_to :perimetro_final,    foreign_key: "logr_idfimperimetro", class_name: "Logradouro"

  belongs_to :cliente, foreign_key: :clie_id, inverse_of: :enderecos

  validate :valida_endereco_de_correspondencia
  before_save :set_cep_id, :set_bairro_id

  private
  def set_cep_id
    self.cep_id = self.logradouro_cep.cep_id if self.logradouro_cep.present?
  end

  def set_bairro_id
    self.bairro_id = self.logradouro_bairro.bairro_id if self.logradouro_bairro.present?
  end

  def valida_endereco_de_correspondencia
    atual_endereco_de_correspondencia = cliente.enderecos.select { |e| e.correspondencia.to_i == 1 }.first
    errors.add(:correspondencia, :taken) if atual_endereco_de_correspondencia &&
                                            self.correspondencia.to_i == 1 &&
                                            atual_endereco_de_correspondencia != self
  end
end
