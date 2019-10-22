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
  belongs_to :ligacao_esgoto_situacao, foreign_key: :lest_id
  belongs_to :perimetro_inicial, foreign_key: :logr_idinicioperimetro, class_name: "Logradouro"
  belongs_to :perimetro_final, foreign_key: :logr_idfimperimetro, class_name: "Logradouro"
  has_one    :gerencia_regional,     through: :localidade
  has_one    :abrangencia,           foreign_key: :imov_id
  has_one    :contrato_medicao,      through: :abrangencia
  has_one    :cep,                   through: :logradouro_cep
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
  has_many   :debitos_automaticos, foreign_key: :imov_id, class_name: 'DebitoAutomatico'
  has_many   :faturamento_situacao_historico, foreign_key: :imov_id, class_name: 'FaturamentoSituacaoHistorico'
  has_many   :imovel_cobrancas_situacoes, -> { ordenar_por_data_implantacao }, foreign_key: :imov_id, class_name: 'ImovelCobrancaSituacao'
  has_many   :cobrancas_situacoes_especiais,  foreign_key: :imov_id, class_name: 'CobrancaSituacaoHistorico'
  has_many   :imagens,  foreign_key: :imov_id, class_name: 'ImovelImagem'
  has_many   :imovel_elos_anormalidades,  foreign_key: :imov_id, class_name: 'ImovelEloAnormalidade'
  belongs_to :rota_alternativa, foreign_key: :rota_idalternativa, class_name: 'Rota'
  has_many   :imovel_cadastros_ocorrencias,  foreign_key: :imov_id, class_name: 'ImovelCadastroOcorrencia'
  has_one    :ligacao_agua, foreign_key: :lagu_id, class_name: 'LigacaoAgua'
  has_many   :imovel_ramos_atividades,    foreign_key: :imov_id, class_name: 'ImovelRamoAtividade'
  has_many   :negativacoes,               foreign_key: :imov_id, class_name: 'NegativadorMovimentoReg'
  has_many   :cobrancas_documentos,       foreign_key: :imov_id, class_name: "CobrancaDocumento"
  has_one    :ligacao_esgoto, foreign_key: :lesg_id, class_name: 'LigacaoEsgoto'
  has_many   :contrato, foreign_key: :imov_id, class_name: 'Contrato'
  belongs_to :hidrometro_instalacao_historico, foreign_key: :hidi_id, class_name: "HidrometroInstalacaoHistorico"
  has_many   :parcelas, foreign_key: :imov_id, class_name: 'Parcelamento'
  has_many   :consumo_historico, foreign_key: :imov_id, class_name: 'ConsumoHistorico'
  has_many   :medicao_historico, foreign_key: :imov_id, class_name: 'MedicaoHistorico'
  has_many   :registros_atendimento, -> { ordenar_por_data_atendimento }, foreign_key: :imov_id, class_name: 'RegistroAtendimento'
  has_many   :pagamentos, -> { condicoes }, foreign_key: :imov_id, class_name: 'Pagamento'
  has_many   :debito_a_cobrar, -> { joins([:debito_credito_situacao_atual, :debito_tipo]).order(ano_mes_cobranca_debito: :desc) }, foreign_key: :imov_id
  has_many   :debito_a_cobrar_historico, -> { joins([:debito_credito_situacao_atual, :debito_tipo]).order(ano_mes_cobranca_debito: :desc) }, foreign_key: :imov_id
  has_many   :conta_historico, -> { where.not(debito_credito_situacao_id_atual: 11).order(ano_mes_referencia: :desc) }, foreign_key: :imov_id
  has_many   :credito_a_realizar, -> { joins([:debito_credito_situacao_atual, :credito_tipo]).order(ano_mes_referencia_credito: :desc) }, foreign_key: :imov_id
  has_many   :credito_a_realizar_historico, -> { joins([:debito_credito_situacao_atual, :credito_tipo]).order(ano_mes_referencia_credito: :desc) }, foreign_key: :imov_id
  has_many   :guia_pagamento, -> { order(ano_mes_referencia_contabil: :desc) }, foreign_key: :imov_id
  has_many   :guia_pagamento_historico, -> { order(ano_mes_referencia_contabil: :desc) }, foreign_key: :imov_id

  delegate   :referencia_assinatura, :to => :contrato_medicao, prefix: true, :allow_nil => true

  def self.medicao_agua(id, referencia)    
    includes([:consumo_historico, medicao_historico: [:leitura_situacao, :leitura_anormalidade_informada, :leitura_anormalidade_faturamento]])
    .where(id: id, "consumo_historico.ligacao_tipo_id" => LigacaoTipo::MODELO[:AGUA], 
          "consumo_historico.referencia_faturamento" => referencia, 
          "medicao_historico.ano_mes_referencia" => referencia, 
          "medicao_historico.ligacao_agua_id" => id).first
  end

  def self.medicao_poco_esgoto(id, referencia)
    joins([:consumo_historico, medicao_historico: [:leitura_situacao, :leitura_anormalidade_informada, :leitura_anormalidade_faturamento]])
    .joins("left outer join micromedicao.consumo_historico che on che.imov_id = #{id} and che.cshi_amfaturamento = #{referencia} and che.lgti_id = #{LigacaoTipo::MODELO[:ESGOTO]}")
    .where(id: id, "consumo_historico.referencia_faturamento" => referencia, "medicao_historico.ano_mes_referencia" => referencia).first
  end

  #TODO melhorar consulta usando os relacionamentos do rails
  def matriculas_associadas
    query = <<-SQL
      SELECT imov.imov_id AS matricula 
      FROM cadastro.imovel imov
      INNER JOIN faturamento.consumo_tarifa cstf ON cstf.cstf_id = imov.cstf_id 
      INNER JOIN cadastro.contrato cntt ON cntt.imov_id = imov.imov_id 
      AND cntt.cntt_nncontrato IS NOT NULL AND cntt.cttp_id = 1
      WHERE imov.cstf_id = #{cstf_id} AND imov.imov_id <> #{imov_id}
      GROUP BY imov.imov_id
    SQL
    ActiveRecord::Base.connection.execute(query)
  end
  
  def dados_contrato
    query = <<-SQL
      SELECT cstc.cstc_nnconsumominimo AS consumo, cstc.cstc_vltarifaminima AS valor_tarifa,
          contrato.cntt_dtcontratoinicio as data_inicio, contrato.cntt_dtcontratofim as data_termino,
          contrato_tipo.cttp_dscontratotipo as tipo, contrato.cntt_nncontrato as numero_contrato,
          contrato_tipo.cttp_id as contrato_id 
      
      FROM faturamento.consumo_tarifa_categoria cstc 
      
        INNER JOIN faturamento.consumo_tarifa_vigencia cstv ON cstc.cstv_id = cstv.cstv_id 
        INNER JOIN cadastro.imovel imov ON imov.cstf_id = cstv.cstf_id AND imov.imov_id = #{imov_id}
        INNER JOIN cadastro.contrato contrato ON contrato.imov_id = imov.imov_id
        INNER JOIN cadastro.contrato_tipo contrato_tipo ON contrato.cttp_id = contrato_tipo.cttp_id
        INNER JOIN cadastro.subcategoria scat ON cstc.catg_id = scat.catg_id
        INNER JOIN cadastro.imovel_subcategoria imov_scat ON scat.scat_id = imov_scat.scat_id AND imov.imov_id = imov_scat.imov_id
      ORDER BY cstv.cstv_dtvigencia DESC limit 1
    SQL
    ActiveRecord::Base.connection.execute(query)
  end

  def self.com_escopo(metodos = [])
    includes([:localidade, :logradouro_bairro, :logradouro_cep, :cep, :setor_comercial, :cliente_imoveis, :clientes].concat(metodos))
  end

  def atributos(metodos = [])
    super([:localidade, :logradouro_cep, :cep, :setor_comercial, :clientes].concat(metodos))
  end

  def endereco_completo
    logradouro_tipo = ""
    logradouro_titulo = ""
    logradouro = ""
    numero = self.numero_imovel ||= ""
    complemento = self.complemento_endereco ||= ""
    bairro = ""
    municipio = ""
    uf = ""
    cep = ""
    perimetro = ""

    if self.logradouro_cep.present?
      if self.logradouro_cep.logradouro.present?
        logradouro_tipo = self.logradouro_cep.logradouro.logradouro_tipo.descricao if logradouro_cep.logradouro.logradouro_tipo.present?
        logradouro_titulo = self.logradouro_cep.logradouro.logradouro_titulo.descricao if logradouro_cep.logradouro.logradouro_titulo.present?
        logradouro = self.logradouro_cep.logradouro.try(:nome)
      end
      if self.logradouro_cep.cep.present?
        cep = self.logradouro_cep.cep.codigo.to_s if self.logradouro_cep.cep.codigo.present?
      end
    end

    if self.logradouro_bairro.present?
      if self.logradouro_bairro.bairro.present?
        bairro = self.logradouro_bairro.bairro.try(:nome)
        if self.logradouro_bairro.bairro.municipio.present?
          municipio = self.logradouro_bairro.bairro.municipio.try(:nome)
          uf = self.logradouro_bairro.bairro.municipio.uf.try(:sigla) if self.logradouro_bairro.bairro.municipio.uf.present?
        end
      end
    end

    if self.perimetro_inicial.present? && self.perimetro_final.present?
      dados_perimetro = []
      dados_perimetro << "ENTRE"
      dados_perimetro << self.perimetro_inicial.logradouro_tipo.descricao
      dados_perimetro << self.perimetro_inicial.nome
      dados_perimetro << "E"
      dados_perimetro << self.perimetro_final.logradouro_tipo.descricao
      dados_perimetro << self.perimetro_final.nome

      perimetro = dados_perimetro.join(" ")
    end

    "".tap do |endereco|
      endereco << logradouro_tipo
      endereco << " " + logradouro_titulo
      endereco << " " + logradouro
      endereco << " - " + numero
      endereco << " - " + complemento_endereco
      endereco << " - " + bairro
      endereco << " " + municipio
      endereco << " " + uf
      endereco << " " + cep.gsub(/\A(\d{5})(\d{3})\Z/, "\\1-\\2")
      endereco << " " + perimetro
    end.strip
  end

  def dados_gerais
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

    {inscricao: inscricao, dica_inscricao: "Localidade.Setor.Quadra.Lote.Sublote", usuario: get_cliente_usuario, hidrometro: get_numero_hidrometro}
  end

  def descricao_de(modelo)
    return if modelo.blank?
    
    modelo.descricao
  end
  
  private

  def get_cliente_usuario
    cliente_imovel = self.cliente_imoveis.where(tipo_relacao: 2, data_fim_relacao: nil).first

    return if cliente_imovel.nil?
    return if cliente_imovel.cliente.nil?

    cliente_imovel.cliente.id.to_s << " - " << cliente_imovel.cliente.nome
  end

  def get_numero_hidrometro
    hidrometro = self.hidrometro_instalacao_agua_historicos.first

    return if hidrometro.nil?

    hidrometro.numero_hidrometro
  end

end
