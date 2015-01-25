class Cliente < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = 'cadastro.cliente'
  self.primary_key = 'clie_id'

  alias_attribute "id",                               "clie_id"                       # integer NOT NULL, -- Id do cliente
  alias_attribute "orgao_emissor_rg_id",              "oerg_id"                       # integer, -- Id do orgao emissor do RG do cliente
  alias_attribute "orgao_emissor_uf_id",              "unfe_id"                       # integer, -- Id da unidade da federacao do orgao emissor
  alias_attribute "cliente_responsavel_superior_id",  "clie_cdclienteresponsavel"     # integer, -- Id do cliente responsavel superior
  alias_attribute "ramo_atividade_id",                "ratv_id"                       # integer, -- Id do ramo de atividade do cliente
  alias_attribute "profissao_id",                     "prof_id"                       # integer, -- Id da profissao do cliente
  alias_attribute "pessoa_sexo_id",                   "psex_id"                       # integer, -- Id do sexo do cliente
  alias_attribute "cliente_tipo_id",                  "cltp_id"                       # integer NOT NULL, -- Id do tipo de cliente

  alias_attribute "nome",                             "clie_nmcliente"                # character varying(50), -- Nome do cliente
  alias_attribute "nome_abreviado",                   "clie_nmabreviado"              # character varying(40), -- Nome abreviado,Nome Fantasia ou sigla
  alias_attribute "cpf",                              "clie_nncpf"                    # character varying(11), -- Numero do CPF do cliente
  alias_attribute "rg",                               "clie_nnrg"                     # character varying(13), -- Numero do RG do cliente
  alias_attribute "data_emissao_rg",                  "clie_dtrgemissao"              # date, -- Data de emissao do RG do cliente
  alias_attribute "nascimento",                       "clie_dtnascimento"             # date, -- Data de nascimento do cliente
  alias_attribute "cnpj",                             "clie_nncnpj"                   # character varying(14), -- Numero do CNPJ do cliente
  alias_attribute "email",                            "clie_dsemail"                  # character varying(40), -- EMAIL do cliente
  alias_attribute "atualizado_em",                    "clie_tmultimaalteracao"        # timestamp without time zone NOT NULL DEFAULT now(), -- Timestamp
  alias_attribute "vencimento",                       "clie_ddvencimento"             # smallint, -- Dia de vencimento das contas dos imoveis para os quais o cliente e responsavel
  alias_attribute "nome_mae",                         "clie_nnmae"                    # varying(50), -- Nome da mae

  alias_attribute "ativo",                            "clie_icuso"                    # smallint, -- Indicador de uso (1_Ativo 2_Inativo)
  alias_attribute "acao_cobranca",                    "clie_icacaocobranca"           # smallint, -- Indicador de acao cobranca (1_Ativo 2_Inativo)
  alias_attribute "cobranca_acrescimos",              "clie_iccobrancaacrescimos"     # smallint DEFAULT 1, -- Indicador de cobranca e acrescimos (1_Ativo 2_Inativo)
  alias_attribute "arquivo_texto",                    "clie_icgeraarquivotexto"       # smallint DEFAULT 2, -- Indicador de arquivo texto (1_Ativo 2_Inativo)
  alias_attribute "vencimento_mes_seguinte",          "clie_icvencimentomesseguinte"  # smallint DEFAULT 2, -- Indicador se o dia de vencimento indicado do cliente quando o mesmo e responsavel e para mes seguinte (1_Ativo  ,2_Inativo)
  alias_attribute "gera_fatura_antecipada",           "clie_icgerafaturaantecipada"   # integer DEFAULT 2, -- Indicador se o cliente permite a geracao de fatura antecipada (1_Ativo 2_Inativo)
  alias_attribute "nome_fantasia_conta",              "clie_icusonomefantasiaconta"   # smallint NOT NULL DEFAULT 2, -- Indicador de uso do nome de fantasia (nome abreviado) na conta
  alias_attribute "permite_negativacao",              "clie_icpermitenegativacao"     # smallint NOT NULL DEFAULT 1, -- indica se o cliente poderá ser negativado
  alias_attribute "negativacao_periodo",              "clie_icnegativacaoperiodo"     # smallint NOT NULL DEFAULT 2, -- Inidicador para negativacao do cliente por periodo

  validates_presence_of   :nome,
                          :cliente_tipo_id,
                          :nome_fantasia_conta,
                          :permite_negativacao,
                          :negativacao_periodo

  validates_presence_of :cpf, if: :pessoa_fisica?

  validates_presence_of :cnpj, if: :pessoa_juridica?

  validates_inclusion_of  :ativo,
                          :negativacao_periodo,
                          :permite_negativacao,
                          :nome_fantasia_conta, in: [1,2]

  validates_inclusion_of  :acao_cobranca,
                          :cobranca_acrescimos,
                          :arquivo_texto,
                          :vencimento_mes_seguinte,
                          :gera_fatura_antecipada, in: [1,2], allow_blank: true

  validates_uniqueness_of :cpf, :cnpj, allow_blank: true

  validates_format_of :cpf, with: /\A\d{11}\z/, allow_blank: true
  validates_format_of :cnpj, with: /\A\d{14}\z/, allow_blank: true
  validate :valida_endereco_de_correspondencia
  validate :valida_telefone_padrao

  scope :join,  -> { }
  scope :nome,  -> (nome) { where("UPPER(clie_nmcliente) LIKE ?", "%#{nome.upcase}%") }
  scope :cpf,   -> (cpf)  { where cpf: cpf }
  scope :cnpj,  -> (cnpj) { where cnpj: cnpj }

  has_many   :enderecos,                    foreign_key: :clie_id, class_name: "ClienteEndereco", inverse_of: :cliente
  has_many   :telefones,                    foreign_key: :clie_id, class_name: "ClienteFone",     inverse_of: :cliente
  belongs_to :cliente_tipo,                 foreign_key: :cltp_id
  belongs_to :profissao,                    foreign_key: :prof_id
  belongs_to :ramo_atividade,               foreign_key: :ratv_id
  belongs_to :cliente_responsavel_superior, foreign_key: :clie_cdclienteresponsavel, class_name: "Cliente"

  accepts_nested_attributes_for :enderecos, allow_destroy: true
  accepts_nested_attributes_for :telefones, allow_destroy: true

  def pessoa_fisica?
    cliente_tipo &&
    self.cliente_tipo.pessoa_fisica_juridica == 1
  end

  def pessoa_juridica?
    cliente_tipo && cliente_tipo.pessoa_fisica_juridica == 2
  end

  private

  def valida_telefone_padrao
    errors.add(:base, :muitos_telefones_padroes) if telefones.select { |t| t.padrao == 1 }.size > 1

    if telefones.any? &&
        !todos_telefones_marcados_para_destruicao? &&
        (nenhum_telefone_padrao? ||
        telefone_padrao_marcado_para_destruicao?)

      errors.add(:base, :ao_menos_um_telefone_padrao)
    end
  end

  def todos_telefones_marcados_para_destruicao?
    telefones.select { |t| !t.marked_for_destruction? }.blank?
  end

  def nenhum_telefone_padrao?
    telefones.size > 0 && telefone_padrao.blank?
  end

  def telefone_padrao
    telefones.select { |t| t.padrao == 1 }.first
  end

  def telefone_padrao_marcado_para_destruicao?
    telefones.select { |t| t.padrao == 1 && t.marked_for_destruction? }.any?
  end

  def valida_endereco_de_correspondencia
    errors.add(:base, :muitos_endereco_correspondencia) if enderecos.select { |e| e.correspondencia == 1 }.size > 1

    if enderecos.any? &&
        !todos_enderecos_marcados_para_destruicao? &&
        (nenhum_endereco_de_correspondencia? ||
        endereco_de_correspondencia_marcado_para_destruicao?)

      errors.add(:base, :ao_menos_um_endereco_correspondencia)
    end
  end

  def todos_enderecos_marcados_para_destruicao?
    enderecos.select { |e| !e.marked_for_destruction? }.blank?
  end

  def nenhum_endereco_de_correspondencia?
    enderecos.size > 0 && endereco_de_correspondencia.blank?
  end

  def endereco_de_correspondencia
    enderecos.select { |e| e.correspondencia == 1 }.first
  end

  def endereco_de_correspondencia_marcado_para_destruicao?
    enderecos.select { |e| e.correspondencia == 1 && e.marked_for_destruction? }.any?
  end
end
