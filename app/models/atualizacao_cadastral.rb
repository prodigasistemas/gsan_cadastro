class AtualizacaoCadastral < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'seguranca.tab_atlz_cadastral'
  self.primary_key = 'tatc_id'

  alias_attribute :id,                         :tatc_id
  alias_attribute :tabela_id,                  :tabe_id
  alias_attribute :leiturista_id,              :leit_id
  alias_attribute :arquivo_texto_atlz_cad_id,  :txac_id
  alias_attribute :codigo_imovel,              :tatc_cdimovel
  alias_attribute :codigo_cliente,             :tatc_cdcliente
  alias_attribute :complemento,                :tatc_complemento

  has_many :coluna_atualizacao_cadastrais, foreign_key: :tatc_id

  DISPONIVEL = 0
  BLOQUEADO = 1
  EM_CAMPO = 2
  TRANSMITIDO = 3
  APROVADO = 4
  EM_FISCALIZACAO = 5
  ATUALIZADO = 6

  SIM = "1"
  NAO = "2"
  EXIBIR_IMOVEL = { todos: "-1", pendentes: "3", aprovados: "0", aprovar_em_lote: "-2" }.freeze
  TODOS = "-1"

  PARAMETROS_OCORRENCIA = { alteracao_hidrometro: "'imac_nnhidrometro'",
                            alteracao_agua: "'last_id'",
                            alteracao_esgoto: "'lest_id'",
                            alteracao_categoria_subcategoria: "'isac_qteconomia'",
                            alteracao_cpf: "'clac_nncpfcnpj'" }

  def self.buscar_atualizacoes_para_recadastramento(params)
    query = <<-SQL
      select
        distinct tatc.tatc_cdimovel as codigo_imovel,
        func.func_nmfuncionario as agente_cadastral,
        siac.siac_dssituacao as situacao
      from seguranca.tab_atlz_cadastral tatc
      --inner join seguranca.operacao_efetuada opef on opef.opef_id = tatc.opef_id
      inner join seguranca.tab_col_atlz_cadastral tcac on  tatc.tatc_id = tcac.tatc_id
      inner join seguranca.tabela_coluna tbco on tbco.tbco_id = tcac.tbco_id
      inner join cadastro.arquivo_texto_atlz_cad txac on tatc.txac_id = txac.txac_id
      inner join micromedicao.rota rota on rota.rota_id = txac.rota_id
      inner join micromedicao.leiturista leit on tatc.leit_id = leit.leit_id
      left join cadastro.funcionario func on leit.func_id = func.func_id
      --left join cadastro.cliente clie on leit.clie_id = clie.clie_id
      left join atualizacaocadastral.imovel_controle_atlz_cad ctrl on ctrl.imov_id = tatc.tatc_cdimovel
      left join cadastro.situacao_atlz_cadastral siac on siac.siac_id = ctrl.siac_id
      inner join cadastro.imovel_atlz_cadastral im on im.imov_id = tatc.tatc_cdimovel
      --left join cadastro.imovel_subcatg_atlz_cad isac on isac.imov_id = tatc.tatc_cdimovel
      left join cadastro.cadastro_ocorrencia cocr on cocr.cocr_id = ctrl.cocr_id
      where 1 = 1
    SQL
    query << "and leit.empr_id = #{params[:empresa_id]}" unless params[:empresa_id].blank?
    query << "\nand leit.leit_id = #{params[:leiturista_id]}" unless params[:leiturista_id].blank?
    unless params[:periodo_inicial].blank?
      query << "\nand ctrl.icac_tmretorno::Date between '#{params[:periodo_inicial].try(:to_date).try(:strftime)}' and "
      query << "'#{params[:periodo_final].try(:to_date).try(:strftime)}'"
    end
    query << "\nand txac.loca_id between #{params[:localidade_id_inicial]} and #{params[:localidade_id_final]}" unless params[:localidade_id_inicial].blank?
    unless params[:setor_comercial_id_inicial].blank?
      query << "\nand txac.txac_cdsetorcomercial between #{params[:setor_comercial_id_inicial]} and #{params[:setor_comercial_id_final]}"
    end
    query << "\nand rota.rota_cdrota between #{params[:rota_id_inicial]} and #{params[:rota_id_final]}" unless params[:rota_id_inicial].blank?

    if params[:exibir_imoveis] and params[:exibir_imoveis] != EXIBIR_IMOVEL[:todos]
      query << "\nand tcac.tcac_dtvalidacao is null" if params[:exibir_imoveis] == EM_CAMPO
      if params[:exibir_imoveis] == EXIBIR_IMOVEL[:aprovar_em_lote]
        query << "\nand cocr.cocr_icvalidacao = #{SIM}"
        situacoes = "#{TRANSMITIDO}"
      else
        situacoes = "#{params[:exibir_imoveis]}"
        situacoes << ", #{EM_FISCALIZACAO}" if params[:exibir_imoveis] == EXIBIR_IMOVEL[:pendentes]
      end
      query << "\nand tcac.tcac_dtvalidacao is not null" if params[:exibir_imoveis] == EXIBIR_IMOVEL[:aprovados]
    else
      query << "\nand ctrl.siac_id not in (#{ATUALIZADO})"
    end

    query << "\nand ctrl.siac_id in (#{situacoes})" unless situacoes.nil?

    if params[:ocorrencias_cadastro].present? and
        params[:ocorrencias_cadastro] != TODOS and
        params[:exibir_imoveis] != EXIBIR_IMOVEL[:aprovar_em_lote]
      query << "\nand cocr.cocr_icvalidacao = #{params[:ocorrencias_cadastro]}"
      query << "\nand cocr.cocr_id = #{params[:cadastro_ocorrencia_id]}" if params[:cadastro_ocorrencia_id].present?
    end

    resultado = ActiveRecord::Base.connection.execute("#{query}\norder by tatc.tatc_cdimovel")
    PARAMETROS_OCORRENCIA.keys.each { |k| params[k] = "2"} if params[:exibir_imoveis] == EXIBIR_IMOVEL[:aprovar_em_lote]
    resultado = tratar_ocorrencias(query, resultado, params) unless params[:exibir_imoveis] == EXIBIR_IMOVEL[:todos]
    resultado
  end

  def self.concatenar_subquery_aprovar_em_lote(query)
    query_imoveis = query.gsub(",
        func.func_nmfuncionario as agente_cadastral,
        siac.siac_dssituacao as situacao", "")
    colunas = PARAMETROS_OCORRENCIA.keys.map {|k| PARAMETROS_OCORRENCIA[k]}.join(',')
    query_imoveis << "\nand lower(tbco.tbco_nmcoluna) in (#{colunas}) group by tatc.tatc_cdimovel"
    "#{query}\nand tatc.tatc_cdimovel not in (#{query_imoveis})"
  end

  def self.tratar_ocorrencias(query, imoveis, params)
    imoveis_filtrados = imoveis
    PARAMETROS_OCORRENCIA.keys.each do |chave|
      if params[chave].present? and params[chave] != TODOS
        imoveis_filtrados = remover_imoveis(imoveis_filtrados,
                      query_ocorrencia(query, PARAMETROS_OCORRENCIA[chave]),
                      params[chave] == NAO)
      end
    end
    imoveis_filtrados
  end

  def self.query_ocorrencia(query, coluna)
    ActiveRecord::Base.connection.execute("#{query}\nand lower(tbco.tbco_nmcoluna) = lower(#{coluna})\norder by tatc.tatc_cdimovel")
  end

  def self.remover_imoveis(imoveis, imovel_ocorrencias, invertido)
    invertido ? (imoveis.to_a - imovel_ocorrencias.to_a) : (imoveis.to_a & imovel_ocorrencias.to_a)
  end
end
