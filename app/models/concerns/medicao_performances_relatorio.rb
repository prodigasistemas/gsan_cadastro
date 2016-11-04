class MedicaoPerformancesRelatorio
  attr_accessor :medicao_performances
  attr_accessor :formato

  def initialize(medicao_performances, formato)
    @medicao_performances = medicao_performances
    @formato              = formato
  end

  def cabecalho
    [
        { name: "situacao",           description: "Situação",                align: "left",    type: "string"  },
        { name: "situacao_ligacao",   description: "Situação da Ligação",     align: "left",    type: "string"  },
        { name: "valor_agua",         description: "Valor da agua (vlr)",     align: "left",    type: "money"   },
        { name: "valor_calculado",    description: "Valor calculado (vlr)",   align: "left",    type: "money"   }
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
      item[:valor_agua]      = medicoes_agrupadas[1].sum(&:valor_diferenca_consumo_agua)
      item[:valor_calculado] = medicoes_agrupadas[1].sum(&:calculo)

      relatorio << item
    end

    base_repasse = relatorio.group_by { |e| e[:situacao_ligacao] }

    base_repasse.each do |item| 
      repasse = {}
      repasse[:situacao] = 'Repasse'
      repasse[:situacao_ligacao] = item[0]
      repasse[:valor_agua] = item[1][0][:valor_agua] - valor_agua(item[1][1])
      repasse[:valor_calculado] = item[1][0][:valor_calculado] - valor_calculado(item[1][1])

      relatorio << repasse
    end

    relatorio
  end

  def valor_agua(item)
    return 0 if item.nil?
    item[:valor_agua]
  end

  def valor_calculado(item)
    return 0 if item.nil?
    item[:valor_calculado]
  end

  def gerar
    params = {}
    
    params[:omitirTotalGeral] = true
    params[:cabecalho]     = cabecalho
    params[:dados]         = dados
    params[:titulo]        = 'Relatório de medição de performance'
    params[:formato]       = @formato
    params[:grupos]        = grupos
    params[:totalizadores] = totalizadores
    params[:name]          = 'relatorio_performance.' + @formato
    relatorio = RelatorioService.new params
    relatorio.gerar
  end
end