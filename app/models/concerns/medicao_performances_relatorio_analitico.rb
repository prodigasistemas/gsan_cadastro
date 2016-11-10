class MedicaoPerformancesRelatorioAnalitico

  def initialize(medicao_performances, params)
    @medicoes = medicao_performances
    @params   = params
    @mes_base_faturamento = ContratoMedicao.find_by(id: params[:contrato_medicao_id]).mes_ano_assinatura
  end

  def cabecalho
    [
        { name: "imovel",               description: "Imóvel",                  align: "left",    type: "string"  },
        { name: "grupo",                description: "Grupo",                   align: "left",    type: "string"  },
        { name: "setor",                description: "Setor",                   align: "left",    type: "string"  },
        { name: "rota",                 description: "Rota",                    align: "left",    type: "string"  },
        { name: "quadra",               description: "Quadra",                  align: "left",    type: "string"  },
        { name: "lote",                 description: "Lote",                    align: "left",    type: "string"  },
        { name: "sublote",              description: "Sublote",                 align: "left",    type: "string"  },
        { name: "situacao_conta",        description: "Situação Conta",         align: "left",    type: "string"  },
        { name: "referencia_conta",      description: "Referencia Conta",       align: "left",    type: "string"  },
        { name: "sit_ligacao_inicial",   description: "Sit Ligação Base",       align: "left",    type: "string"  },
        { name: "sit_ligacao_atual",     description: "Sit Ligação Atual",      align: "left",    type: "string"  },
        { name: "econ_iniciais_imovel",  description: "Economias Base",         align: "left",    type: "string"  },
        { name: "econ_atuais_imovel",    description: "Economias Atual",        align: "left",    type: "string"  },
        { name: "consumo_mes_zero",      description: "Consumo Base",           align: "left",    type: "string"  },
        { name: "consumo_referencia",    description: "Consumo Atual",          align: "left",    type: "string"  },
        { name: "faturamento_mes_zero", description: "Valor Agua Base",         align: "left",    type: "money"   },
        { name: "valor_faturado",       description: "Valor Agua Atual",        align: "left",    type: "money"   },
        { name: "valor_diferenca",      description: "Valor da Diferença",      align: "left",    type: "money"   },
        { name: "valor_calculado",      description: "Valor Devido",            align: "left",    type: "money"   }
    ]
  end

  def dados
    relatorio = []
    
    @medicoes.each do |medicao|
      item = {}
      item[:imovel]               = medicao.imovel_id
      item[:grupo]                = medicao.imovel.quadra.rota.grupo_faturamento_id
      item[:setor]                = medicao.imovel.setor_comercial.codigo
      item[:rota]                 = medicao.imovel.quadra.rota_id
      item[:quadra]               = medicao.imovel.quadra_id
      item[:lote]                 = medicao.imovel.numero_lote
      item[:sublote]              = medicao.imovel.numero_sublote

      conta = buscar_conta_por_referencia_contabil(medicao.imovel_id, medicao.ano_mes_referencia)
      
      item[:situacao_conta]       = situacao_conta(conta)
      item[:referencia_conta]     = referencia_conta(conta)
      item[:sit_ligacao_inicial]  = medicao.situacao_ligacao_inicial
      item[:sit_ligacao_atual]    = medicao.situacao_ligacao_atual
      item[:econ_iniciais_imovel] = medicao.economias_iniciais_imovel
      item[:econ_atuais_imovel]   = medicao.economias_atuais_imovel
      item[:consumo_mes_zero]     = medicao.consumo_mes_zero
      item[:consumo_referencia]   = medicao.consumo_referencia
      item[:faturamento_mes_zero] = medicao.valor_agua_faturado_mes_zero
      item[:valor_faturado]       = medicao.valor_agua_faturado
      item[:valor_diferenca]      = medicao.valor_diferenca_agua
      item[:valor_calculado]      = medicao.calculo

      relatorio << item
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

  def buscar_conta_por_referencia_contabil(imovel_id, referencia)
    conta = Conta.find_by(imovel_id: imovel_id, ano_mes_referencia_contabil: referencia)

    if conta.nil?
      conta = ContaHistorico.find_by(imovel_id: imovel_id, ano_mes_referencia_contabil: referencia)
    end

    return conta
  end

  def referencia_conta(conta)
    if conta.present?
      conta.mes_ano_referencia
    else
      ''
    end
  end

  def situacao_conta(conta)
    if conta.present?
      conta.debito_credito_situacao.descricao
    else
      ''
    end
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
    params[:titulo]        = 'Relatório Analítico de Medição de Performance'
    params[:formato]       = @params[:formato]
    params[:subtitulo]     = filtro_relatorio
    params[:name]          = 'relatorio_analitico_performance.' + @params[:formato]
    relatorio = RelatorioService.new params
    relatorio.gerar
  end
end