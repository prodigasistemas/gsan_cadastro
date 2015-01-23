class Cliente < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = 'cadastro.cliente'
  self.primary_key = 'clie_id'

  validates_presence_of   :nome,
                          :cliente_tipo_id,
                          :nome_fantasia_conta,
                          :permite_negativacao,
                          :negativacao_periodo

  validates_inclusion_of  :ativo,
                          :negativacao_periodo,
                          :permite_negativacao,
                          :nome_fantasia_conta, in: [1,2]

  validates_inclusion_of  :acao_cobranca,
                          :cobranca_acrescimos,
                          :arquivo_texto,
                          :vencimento_mes_seguinte,
                          :gera_fatura_antecipada, in: [1,2], allow_nil: true

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

  scope :join,  -> { }
  scope :nome,  -> (nome) { where("UPPER(clie_nmcliente) LIKE ?", "%#{nome.upcase}%") }
  scope :cpf,   -> (cpf)  { where cpf: cpf }
  scope :cnpj,  -> (cnpj) { where cnpj: cnpj }

  has_many :enderecos, class_name: "ClienteEndereco", foreign_key: "clie_id"
  belongs_to :cliente_tipo, foreign_key: :cltp_id
  belongs_to :profissao,    foreign_key: :prof_id

  accepts_nested_attributes_for :enderecos, allow_destroy: true
end
