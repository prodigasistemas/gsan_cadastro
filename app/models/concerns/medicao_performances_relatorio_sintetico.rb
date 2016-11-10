class MedicaoPerformancesRelatorioSintetico
  attr_accessor :medicao_performances
  attr_accessor :formato

  def initialize(medicao_performances, params)
    @medicao_performances = medicao_performances
    @formato              = params[:formato]
    @params               = params
  end

  def cabecalho
    [
        { name: "situacao",           description: "Situação",                align: "left",    type: "string"  },
        { name: "situacao_ligacao",   description: "Situação da Ligação",     align: "left",    type: "string"  },
        { name: "valor_agua",         description: "Valor Faturado de Água",  align: "left",    type: "money"   },
        { name: "valor_diferenca",    description: "Valor da Diferença",      align: "left",    type: "money"   },
        { name: "valor_calculado",    description: "Valor Devido",            align: "left",    type: "money"   }
    ]
  end

  def grupos
      [
        { name: "situacao" },
        { name: "situacao_ligacao" }
      ]
  end

  def totalizadores
    [
      {name:"valor_agua"},
      {name:"valor_diferenca"},
      {name:"valor_calculado"}
    ]
  end

  def dados
    relatorio = []

    medicoes = @medicao_performances.group_by{|e| [e.situacao, e.situacao_ligacao]}
    
    medicoes.each do |medicoes_agrupadas|
      item = {}
      item[:situacao] = medicoes_agrupadas[0][0]
      item[:situacao_ligacao] = medicoes_agrupadas[0][1]
      item[:valor_agua]       = medicoes_agrupadas[1].sum(&:valor_agua_faturado)
      item[:valor_diferenca]  = medicoes_agrupadas[1].sum(&:medp_vldiferencaagua)
      item[:valor_calculado]  = medicoes_agrupadas[1].sum(&:calculo)

      relatorio << item
    end

    base_repasse = relatorio.group_by { |e| e[:situacao_ligacao] }

    base_repasse.each do |item| 
      repasse = {}
      repasse[:situacao] = 'Repasse'
      repasse[:situacao_ligacao] = item[0]
      repasse[:valor_agua]       = item[1][0][:valor_agua]      - valor_agua(item[1][1])
      repasse[:valor_diferenca]  = item[1][0][:valor_diferenca] - valor_diferenca(item[1][1])
      repasse[:valor_calculado]  = item[1][0][:valor_calculado] - valor_calculado(item[1][1])


      relatorio << repasse
    end    

    relatorio
  end

  def valor_diferenca(item)
    return 0 if item.nil?
    item[:valor_diferenca]
  end

  def valor_agua(item)
    return 0 if item.nil?
    item[:valor_agua]
  end

  def valor_calculado(item)
    return 0 if item.nil?
    item[:valor_calculado]
  end

  def filtro_relatorio
    filtro = ""

    if @params[:contrato_medicao_id]
      contrato = ContratoMedicao.find(@params[:contrato_medicao_id])
      filtro = "Contrato: " + contrato.numero
    end

    if @params['referencia'].present?
      filtro += " | Referência: " + @params['referencia'][4..5] + "/" + @params['referencia'][0..3]
    end

    if @params[:localidade_id].present?
      filtro += " | Localidade: " + Localidade.find(@params[:localidade_id]).nome
    end

    if @params[:setor_comercial_id].present?
      filtro += " | Setor: " + SetorComercial.find(@params[:setor_comercial_id]).nome
    end

    if @params[:rota_id].present?
      filtro += " | Rota: " + @params[:rota_id]
    end

    return filtro
  end

  def gerar
    params = {}
    
    params[:omitirTotalGeral] = true
    params[:cabecalho]     = cabecalho
    params[:dados]         = dados
    params[:titulo]        = 'Relatório de Medição de Performance'
    params[:formato]       = @formato
    params[:grupos]        = grupos
    params[:totalizadores] = totalizadores
    params[:subtitulo]     = filtro_relatorio
    params[:name]          = 'relatorio_performance.' + @formato
    relatorio = RelatorioService.new params
    relatorio.gerar
  end
end