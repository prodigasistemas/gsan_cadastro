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
  alias_attribute "observacao_categoria",                                               "imov_dsobservacaotegoria"

  scope :com_dados, -> { com_escopo.joins(:quadra) }
  scope :nao_excluido, -> { com_escopo.where('imovel_excluido is null OR imovel_excluido <> 1') }
  scope :por_cliente, -> (dados_cliente) { com_escopo.joins(:clientes).where(cliente: dados_cliente) }

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
  has_many   :clientes,               through: :cliente_imoveis
  belongs_to :despejo,               foreign_key: :depj_id
  belongs_to :area_construida_faixa,       foreign_key: :acon_id
  belongs_to :faixa_reservatorio_inferior, foreign_key: :resv_idreservatorioinferior, class_name: 'ReservatorioVolumeFaixa'
  belongs_to :faixa_reservatorio_superior, foreign_key: :resv_idreservatoriosuperior, class_name: 'ReservatorioVolumeFaixa'
  belongs_to :piscina_volume_faixa, foreign_key: :pisc_id
  belongs_to :fonte_abastecimento, foreign_key: :ftab_id
  belongs_to :poco_tipo, foreign_key: :poco_id
  belongs_to :quadra_face, foreign_key: :qdfa_id
  belongs_to :pavimento_calcada, foreign_key: :pcal_id
  belongs_to :pavimento_rua, foreign_key: :prua_id
  belongs_to :cadastro_ocorrencia, foreign_key: :cocr_id
  belongs_to :anormalidade, foreign_key: :eanm_id, class_name: 'Anormalidade'
  belongs_to :tipo_habitacao, foreign_key: :imha_id, class_name: 'ImovelTipoHabitacao'
  belongs_to :tipo_construcao, foreign_key: :imco_id, class_name: 'ImovelTipoConstrucao'
  belongs_to :tipo_cobertura, foreign_key: :imcb_id, class_name: 'ImovelTipoCobertura'
  belongs_to :tipo_propriedade, foreign_key: :impr_id, class_name: 'ImovelTipoPropriedade'
  has_many   :atualizacoes_cadastrais, foreign_key: :imov_id, class_name: 'ImovelControleAtualizacaoCadastral'
  has_many   :termo_atualizacao_comunicados, foreign_key: :imov_id, class_name: 'ComunicadoEmitirConta'
  belongs_to :perfil_imovel, foreign_key: :iper_id, class_name: 'ImovelPerfil'
  belongs_to :consumo_tarifa, foreign_key: :cstf_id, class_name: 'ConsumoTarifa'
  belongs_to :funcionario, foreign_key: :funcionario_id
  has_many   :vencimentos_alternativos,  foreign_key: :imov_id, class_name: 'VencimentoAlternativo'

  delegate :referencia_assinatura, :to => :contrato_medicao, prefix: true, :allow_nil => true

  def self.com_escopo(metodos = [])
    includes([:localidade, :logradouro_bairro, :logradouro_cep, :setor_comercial, :cliente_imoveis, :clientes].concat(metodos))
  end

  def atributos(metodos = [])
    super([:localidade, :logradouro_cep, :setor_comercial, :clientes].concat(metodos))
  end

  def dados_cadastrais
    cadastro = {}

    cadastro[:perfil_imovel] = get_perfil_imovel
    cadastro[:area_construida] = get_area_construida
    cadastro[:volume_reservatorio_inferior] = get_volume_reservatorio_inferior
    cadastro[:volume_reservatorio_superior] = get_volume_reservatorio_superior
    cadastro[:piscina_volume_faixa] = get_piscina_volume_faixa
    cadastro[:fonte_abastecimento] = get_fonte_abastecimento
    cadastro[:tipo_poco] = get_tipo_poco
    cadastro[:distrito_operacional] = get_distrito_operacional
    cadastro[:divisao_esgoto] = get_divisao_esgoto
    cadastro[:cadastro_ocorrencia] = get_cadastro_ocorrencia
    cadastro[:anormalidade] = get_anormalidade
    cadastro[:jardim] = get_jardim
    cadastro[:tipo_habitacao] = get_tipo_habitacao
    cadastro[:tipo_construcao] = get_tipo_construcao
    cadastro[:tipo_cobertura] = get_tipo_cobertura
    cadastro[:tipo_propriedade] = get_tipo_propriedade
    cadastro[:data_processamento] = get_data_processamento
    cadastro[:data_geracao_tac] = get_data_geracao_tac
    cadastro[:subcategorias] = get_imovel_subcategorias
    cadastro[:total_economias] = get_total_economias
    cadastro[:pavimento_calcada] = get_pavimento_calcada
    cadastro[:pavimento_rua] = get_pavimento_rua

    cadastro
  end

  def dados_adicionais
    cadastro = {}

    cadastro[:consumo_tarifa] = get_consumo_tarifa
    cadastro[:funcionario] = get_funcionario
    cadastro[:vencimentos_alternativos] = get_vencimentos_alternativos

    cadastro
  end

  def endereco_completo
    endereco = ""
    logradouro_tipo = ""
    logradouro_titulo = ""
    logradouro = "" 
    bairro = ""
    municipio = ""
    uf = ""
    cep = ""

    if not self.logradouro_cep.nil?
      if not self.logradouro_cep.logradouro.nil?
        logradouro_tipo = self.logradouro_cep.logradouro.logradouro_tipo.descricao if not logradouro_cep.logradouro.logradouro_tipo.nil?
        logradouro_titulo = self.logradouro_cep.logradouro.logradouro_titulo.descricao if not logradouro_cep.logradouro.logradouro_titulo.nil?
        logradouro = self.logradouro_cep.logradouro.try(:nome)
      end
      if not self.logradouro_cep.cep.nil?
        cep = self.logradouro_cep.cep.codigo.to_s if not self.logradouro_cep.cep.codigo.nil?
      end
    end

    if not self.logradouro_bairro.nil?
      if not self.logradouro_bairro.bairro.nil?
        bairro = self.logradouro_bairro.bairro.try(:nome)
        if not self.logradouro_bairro.bairro.municipio.nil?
          municipio = self.logradouro_bairro.bairro.municipio.try(:nome)
          uf = self.logradouro_bairro.bairro.municipio.uf.try(:sigla) if not self.logradouro_bairro.bairro.municipio.uf.nil?
        end
      end
    end

    endereco << logradouro_tipo
    endereco << " " +logradouro_titulo
    endereco << " " +logradouro
    endereco << " - " +self.numero_imovel ||= ""
    endereco << " - " +self.complemento_endereco ||= ""
    endereco << " - " +bairro
    endereco << " " +municipio
    endereco << " " +uf
    endereco << " " +cep.gsub(/\A(\d{5})(\d{3})\Z/, "\\1-\\2")

    endereco
  end

  def numero_inscricao
    inscricao = ""

    inscricao = localidade_id.to_s.rjust(3, '0') << "."

    if(setor_comercial.blank?)
      inscricao << "000."
    else
      inscricao << setor_comercial.codigo.to_s.rjust(3, '0') << "."
    end  

    if(quadra.blank?)
      inscricao << "0000."
    else
      inscricao << quadra.numero_quadra.to_s.rjust(4, '0') << "."
    end  

    inscricao << numero_lote.to_s.rjust(4, '0') << "."
    inscricao << numero_sublote.to_s.rjust(3, '0')

    inscricao
  end

  private

  def get_vencimentos_alternativos 
    vencimentos = []

    vencimentos_alternativos.map do |vencimento|
      v = {}
      v[:id] = vencimento.id
      v[:data_implantacao] = vencimento.data_implantacao
      v[:data_vencimento] = vencimento.data_vencimento
      v[:data_exclusao] = vencimento.data_exclusao

      vencimentos << v
    end

    vencimentos
  end

  def get_perfil_imovel
    return "" if perfil_imovel.nil?

    perfil_imovel.descricao
  end

  def get_imovel_subcategorias
    subcategorias = []

    return subcategorias if imovel_subcategorias.blank?

    imovel_subcategorias.map do |s|
      break if s.subcategoria.blank?

      sub = {}
      sub[:subcategoria] = s.subcategoria.try(:descricao)
      sub[:categoria] = s.subcategoria.categoria.try(:descricao)
      sub[:qtd_economias] = s.qtd_economias

      subcategorias << sub
    end

    subcategorias
  end

  def get_total_economias
    return "" if imovel_subcategorias.blank?

    imovel_subcategorias.sum(&:qtd_economias)
  end

  def get_area_construida
    return self.area_construida if not self.area_construida.nil?
    return self.area_construida_faixa.medidas if not self.area_construida_faixa.nil?

    return ""
  end

  def get_volume_reservatorio_inferior
    return volume_reservatorio_inferior if not volume_reservatorio_inferior.nil?
    return "" if faixa_reservatorio_inferior.nil?

    faixa_reservatorio_inferior.medidas
  end

  def get_volume_reservatorio_superior
    return volume_reservatorio_superior if not volume_reservatorio_superior.nil?
    return "" if faixa_reservatorio_superior.nil?

    faixa_reservatorio_superior.medidas
  end

  def get_piscina_volume_faixa
    return volume_piscina if not volume_piscina.nil?
    return "" if piscina_volume_faixa.nil?

    piscina_volume_faixa.medidas
  end

  def get_fonte_abastecimento
    return "" if fonte_abastecimento.nil?

    fonte_abastecimento.descricao
  end

  def get_tipo_poco
    return "" if poco_tipo.nil?

    poco_tipo.descricao
  end

  def get_distrito_operacional
    return "" if quadra_face.nil?
    return "" if quadra_face.distrito_operacional.nil?

    quadra_face.distrito_operacional.descricao
  end

  def get_divisao_esgoto
    return "" if quadra_face.nil?
    return "" if quadra_face.bacia.nil?
    return "" if quadra_face.bacia.sistema_esgoto.nil?
    return "" if quadra_face.bacia.sistema_esgoto.divisao_esgoto.nil?

    quadra_face.bacia.sistema_esgoto.divisao_esgoto.descricao
  end

  def get_pavimento_calcada
    return "" if pavimento_calcada.nil?

    pavimento_calcada.descricao
  end

  def get_pavimento_rua
    return "" if pavimento_rua.nil?

    pavimento_rua.descricao
  end

  def get_cadastro_ocorrencia
    return "" if cadastro_ocorrencia.nil?

    cadastro_ocorrencia.descricao
  end

  def get_anormalidade
    return "" if anormalidade.nil?

    anormalidade.descricao
  end

  def get_jardim
    return "" if jardim.nil?
    return "SIM" if jardim == 1

    "NÃO"
  end

  def get_tipo_habitacao
    return "" if tipo_habitacao.nil?

    tipo_habitacao.descricao
  end

  def get_tipo_construcao
    return "" if tipo_construcao.nil?

    tipo_construcao.descricao
  end

  def get_tipo_cobertura
    return "" if tipo_cobertura.nil?

    tipo_cobertura.descricao
  end

  def get_tipo_propriedade
    return "" if tipo_propriedade.nil?

    tipo_propriedade.descricao
  end

  def get_telefone

  end

  def get_data_processamento
    atualizacao = atualizacoes_cadastrais.last

    return "" if atualizacao.nil?

    atualizacao.tempo_processamento
  end

  def get_data_geracao_tac
    return "" if termo_atualizacao_comunicados.nil?
    tacs = termo_atualizacao_comunicados.where(tipo_comunicado: 1)

    return "" if tacs.empty?
    tacs.last.data_geracao
  end

  def get_consumo_tarifa
    return "" if consumo_tarifa.nil?

    consumo_tarifa.descricao
  end

  def get_funcionario
    return "" if funcionario.nil?

    f = "(" << funcionario.id << ") " << funcionario.nome ||= ""

    f
  end
end
