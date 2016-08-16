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
  alias_attribute "tipo_pessoa", "cliente_pessoa_tipo"
  alias_attribute "cpf_cnpj", "cnpj_ou_cpf"
  alias_attribute "uf", "sigla_unidade_federacao"
  alias_attribute "tipo_sexo", "descricao_pessoa_sexo"
  alias_attribute "telefone", "cliente_telefone"

  belongs_to :pessoa_sexo, foreign_key: "psex_id"
  belongs_to :unidade_federacao, foreign_key: "unfe_id"
  belongs_to :cliente_tipo, foreign_key: "cltp_id"
  belongs_to :cliente, foreign_key: "clie_id"

  has_many :cliente_fone_retornos, foreign_key: "clir_id"

  def cliente_pessoa_tipo
    cliente.cliente_tipo.pessoa_tipo
  end

  def cnpj_ou_cpf
    return cliente.cpf if cliente.pessoa_fisica?
    cliente.cnpj
  end

  def sigla_unidade_federacao
    unidade_federacao.sigla
  end

  def descricao_pessoa_sexo
    pessoa_sexo.descricao
  end

  def cliente_telefone
    if cliente_fone_retornos.present?
      "#{cliente_fone_retornos.first.ddd}#{cliente_fone_retornos.first.fone}"
    else
      ""
    end
  end

end