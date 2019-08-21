class Imovel < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cadastro.imovel'
  self.primary_key = 'imov_id'

  alias_attribute "id",                                                                 "imov_id"

  alias_attribute "logradouro_bairro_id",                                               "lgbr_id"
  alias_attribute "logradouro_cep_id",                                                  "lgcp_id"
  alias_attribute "bairro_id",                                                          "bair_id"
  alias_attribute "vencimento_mes_seguinte",                                            "imov_icvencimentomesseguinte"
  alias_attribute "localidade_id",                                                      "loca_id"
  alias_attribute "setor_comercial_id",                                                 "stcm_id"
  alias_attribute "quadra_id",                                                          "qdra_id"
  alias_attribute "numero_lote",                                                        "imov_nnlote"
  alias_attribute "numero_sublote",                                                     "imov_nnsublote"
  alias_attribute "testada_lote",                                                       "imov_nntestadalote"
  alias_attribute "numero_imovel",                                                      "imov_nnimovel"
  alias_attribute "complemento_endereco",                                               "imov_dscomplementoendereco"
  alias_attribute "faixa_area_construida_id",                                           "acon_id"
  alias_attribute "imovel_condominio_id",                                               "imov_idimovelcondominio"
  alias_attribute "indicador_imovel_condominio",                                        "imov_icimovelcondominio"
  alias_attribute "imovel_principal_id",                                                "imov_idimovelprincipal"
  alias_attribute "tipo_despejo_id",                                                    "depj_id"
  alias_attribute "volume_reservatorio_superior",                                       "imov_voreservatoriosuperior"
  alias_attribute "faixa_reservatorio_superior_id",                                     "resv_idreservatoriosuperior"
  alias_attribute "volume_reservatorio_inferior",                                       "imov_voreservatorioinferior"
  alias_attribute "faixa_reservatorio_inferior_id",                                     "resv_idreservatorioinferior"
  alias_attribute "tipo_pavimento_calcada_id",                                          "pcal_id"
  alias_attribute "tipo_pavimento_rua_id",                                              "prua_id"
  alias_attribute "fonte_abastecimento_id",                                             "ftab_id"
  alias_attribute "situacao_ligacao_agua_id",                                           "last_id"
  alias_attribute "situacao_ligacao_esgoto_id",                                         "lest_id"
  alias_attribute "perfil_imovel_id",                                                   "iper_id"
  alias_attribute "situacao_especial_de_cobranca_id",                                   "cbst_id"
  alias_attribute "situacao_especial_faturamento_id",                                   "ftst_id"
  alias_attribute "volume_piscina",                                                     "imov_vopiscina"
  alias_attribute "faixa_volume_piscina_id",                                            "pisc_id"
  alias_attribute "tipo_poco_id",                                                       "poco_id"
  alias_attribute "data_supressao_parcial",                                             "imov_dtsupressaoparcial"
  alias_attribute "data_infracao",                                                      "imov_dtinfracao"
  alias_attribute "pontos_utilizacao",                                                  "imov_nnpontosutilizacao"
  alias_attribute "moradores",                                                          "imov_nnmorador"
  alias_attribute "retificadores",                                                      "imov_nnretificacao"
  alias_attribute "excecoes_leitura",                                                   "imov_nnleituraexcecao"
  alias_attribute "parcelamentos",                                                      "imov_nnparcelamento"
  alias_attribute "reparcelamentos",                                                    "imov_nnreparcelamento"
  alias_attribute "reparcelamentos_consecutivos",                                       "imov_nnreparcmtconsec"
  alias_attribute "vencimento_alternativo",                                             "imov_ddvencimento"
  alias_attribute "iptu",                                                               "imov_nniptu"
  alias_attribute "contrato",                                                           "imov_nncontratoenergia"
  alias_attribute "indicador_emissao_extrato_faturamento",                              "imov_icemsextfatmt"
  alias_attribute "indicador_debito_conta",                                             "imov_icdebitoconta"
  alias_attribute "imovel_excluido",                                                    "imov_icexclusao"
  alias_attribute "coordenada_x",                                                       "imov_nncoordenadax"
  alias_attribute "coordenada_y",                                                       "imov_nncoordenaday"
  alias_attribute "anormalidade_id",                                                    "eanm_id"
  alias_attribute "ocorrencia_id",                                                      "cocr_id"
  alias_attribute "historico_instalacao_hidrometro_poco_id",                            "hidi_id"
  alias_attribute "anormalidade_leitura_imoveis_sem_hidrometro_fiscalizado_leitura_id", "ltan_id"
  alias_attribute "atualizado_em",                                                      "imov_tmultimaalteracao"
  alias_attribute "tarifa_id",                                                          "cstf_id"
  alias_attribute "tipo_faturamento_id",                                                "fttp_id"
  alias_attribute "referencia_numero_id",                                               "edrf_id"
  alias_attribute "logradouro_id",                                                      "logr_id"
  alias_attribute "economias",                                                          "imov_qteconomia"
  alias_attribute "suspensao_abastecimento",                                            "imov_icsuspensaoabastecimento"
  alias_attribute "faturamento_situacao_motivo_id",                                     "ftsm_id"
  alias_attribute "area_construida",                                                    "imov_nnareaconstruida"
  alias_attribute "tipo_cobranca_situacao_id",                                          "cbsp_id"
  alias_attribute "tipo_envio_conta_id",                                                "icte_id"
  alias_attribute "jardim",                                                             "imov_icjardim"
  alias_attribute "sequencial_rota_leitura",                                            "imov_nnsequencialrota"
  alias_attribute "nome",                                                               "imov_nmimovel"
  alias_attribute "funcionario_id",                                                     "func_id"
  alias_attribute "habitacao_id",                                                       "imha_id"
  alias_attribute "tipo_propriedade_id",                                                "impr_id"
  alias_attribute "tipo_constricao_id",                                                 "imco_id"
  alias_attribute "tipo_cobertura_id",                                                  "imcb_id"
  alias_attribute "rota_entrega_id",                                                    "rota_identrega"
  alias_attribute "sequencia_rota_entrega",                                             "imov_nnsequencialrotaentrega"
  alias_attribute "data_contrato",                                                      "imov_dtenviocontrato"
  alias_attribute "codigo_atualizacao_id",                                              "siac_id"
  alias_attribute "logradouro_inicio_perimetro_id",                                     "logr_idinicioperimetro"
  alias_attribute "logradouro_final_perimetro_id",                                      "logr_idfimperimetro"
  alias_attribute "face_quadra_id",                                                     "qdfa_id"
  alias_attribute "rota_alternativa_id",                                                "rota_idalternativa"
  alias_attribute "medidor_energia_id",                                                 "imov_nnmedidorenergia"
  alias_attribute "visita_comercial_id",                                                "imov_dtvisitacomercial"
  alias_attribute "informacoes",                                                        "imov_dsinformacaocomplementar"
  alias_attribute "codigo_debito_automatico",                                           "imov_cddebitoautomatico"
  alias_attribute "reincidencia_infracao",                                              "imov_icreincidenciainfracao"
  alias_attribute "quadra_entrega",                                                     "imov_nnquadraentrega"
  alias_attribute "ano_mes_exclusao_tarifa_social",                                     "imov_amrefexclusaotarifasocial"
  alias_attribute "nivel_instalacao_esgoto",                                            "imov_icnivelinstalacaoesgoto"
  alias_attribute "utiliza_rateio_area_comum",                                          "imov_icimovelareacomum"
  alias_attribute "categoria",                                                          "imov_idcategoriaprincipal"
  alias_attribute "subcategoria",                                                       "imov_idsubcategoriaprincipal"
  alias_attribute "percentual_abastecimento",                                           "imov_percentual_abastecimento"

  scope :com_dados, -> { com_escopo.joins(:quadra) }
  scope :nao_excluido, -> { com_escopo.where('imovel_excluido is null OR imovel_excluido <> 1') }

  scope :por_endereco, -> (nome){ joins(logradouro: :logradouro_tipo).joins(logradouro_bairro: {bairro: {municipio: :uf}}).joins(logradouro: :logradouro_titulo)
  .where("UPPER(lgtp_dslogradourotipo) LIKE ? OR UPPER(logr_nmlogradouro) LIKE ? OR UPPER(lgtp_dsabreviado) LIKE ? OR UPPER(bair_nmbairro) LIKE ? OR UPPER(lgtt_dslogradourotitulo) LIKE ? OR UPPER(muni_nmmunicipio) LIKE ? OR UPPER(unfe_dsufsigla) LIKE ?",
   "%#{nome.upcase}%", "%#{nome.upcase}%", "%#{nome.upcase}%", "%#{nome.upcase}%", "%#{nome.upcase}%", "%#{nome.upcase}%", "%#{nome.upcase}%") }

  belongs_to :logradouro_cep,        foreign_key: :lgcp_id
  belongs_to :logradouro_bairro,     foreign_key: :lgbr_id
  belongs_to :localidade,            foreign_key: :loca_id
  belongs_to :setor_comercial,       foreign_key: :stcm_id
  belongs_to :quadra,                foreign_key: :qdra_id, optional: true
  belongs_to :ligacao_agua_situacao, foreign_key: :last_id
  has_one    :gerencia_regional,     through: :localidade
  has_one    :abrangencia,           foreign_key: :imov_id
  has_one    :contrato_medicao,      through: :abrangencia
  has_many   :hidrometro_instalacao_esgoto_historicos, foreign_key: :imov_id, class_name: 'HidrometroInstalacaoHistorico'
  has_many   :hidrometro_instalacao_agua_historicos,   foreign_key: :lagu_id, class_name: 'HidrometroInstalacaoHistorico'
  has_many   :contas, -> { order(ano_mes_referencia: :desc) }, foreign_key: :imov_id
  has_many   :imovel_subcategorias,  foreign_key: :imov_id, class_name: 'ImovelSubcategoria'
  has_many   :subcategorias, through: :imovel_subcategorias
  has_many   :cliente_imoveis, foreign_key: :imov_id, class_name: 'ClienteImovel'
  has_one    :logradouro,            through: :logradouro_cep

  delegate :referencia_assinatura, :to => :contrato_medicao, prefix: true, :allow_nil => true

  def atributos(metodos = [])
    super([:localidade, :logradouro_cep, :setor_comercial].concat(metodos))
  end

  def self.com_escopo(metodos = [])
    includes([:localidade, :logradouro_bairro, :logradouro_cep, :setor_comercial].concat(metodos))
  end

  def endereco_completo
    endereco = ""
    endereco << self.logradouro_cep.logradouro.logradouro_tipo.descricao if logradouro_cep.logradouro.logradouro_tipo
    endereco << " " + self.logradouro_cep.logradouro.logradouro_titulo.descricao if self.logradouro_cep.logradouro.logradouro_titulo
    endereco << " " + self.logradouro_cep.logradouro.nome
    endereco << " - " +self.numero_imovel
    endereco << " - " +self.complemento_endereco
    endereco << " - " +self.logradouro_bairro.bairro.nome
    endereco << " "   +self.logradouro_bairro.bairro.municipio.nome
    endereco << " "   +self.logradouro_bairro.bairro.municipio.uf.sigla
    endereco << " "   +self.logradouro_cep.cep.codigo.to_s

    endereco
  end
end
