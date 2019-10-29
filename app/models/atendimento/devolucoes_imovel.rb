class Atendimento::DevolucoesImovel < Imovel
  def devolucoes
    cadastro = {}    
    
    contas  = []
    contas_historico  = []
    guias   = []
    guias_historico   = []
    debitos = []
    debitos_historico = []
    valores = []
    valores_historico = []

    preenche_dados(Devolucao.por_imovel(self.id), contas, guias, debitos, valores)
    preenche_dados(DevolucaoHistorico.por_imovel(self.id), contas_historico, guias_historico, debitos_historico, valores_historico)

    cadastro[:contas]  = contas
    cadastro[:contas_historico]  = contas_historico
    cadastro[:guias]   = guias
    cadastro[:guias_historico]   = guias_historico
    cadastro[:debitos] = debitos
    cadastro[:debitos_historico] = debitos_historico
    cadastro[:valores] = valores
    cadastro[:valores_historico] = valores_historico

    cadastro
  end

  private 

  def preenche_dados(devolucoes, contas = [], guias = [], debitos = [], valores = [])    
    devolucoes.each do |dev|  
      if(dev.guia_devolucao.present?)
        if(dev.guia_devolucao.documento_tipo.id == DocumentoTipo::TIPO[:conta])
          contas << preenche_conta(dev)
        elsif(dev.guia_devolucao.documento_tipo.id == DocumentoTipo::TIPO[:guia_pagamento])
          guias << preenche_guia(dev)
        elsif(dev.guia_devolucao.documento_tipo.id == DocumentoTipo::TIPO[:debito_a_cobrar])
          debitos << preenche_debito(dev)
        end
      else
        if(dev.ano_mes_referencia_devolucao.present?)
          contas << preenche_conta(dev)
        else
          valores << preenche_valores(dev)
        end
      end
    end 
  end

  def preenche_conta(devolucao)
    conta = {}

    conta[:mes_ano] = devolucao.ano_mes_referencia_devolucao
    conta[:valor_conta] = nil
    
    complemento(conta, devolucao)
  end

  def preenche_guia(devolucao)
    guia = {}

    cliente = nil
    guia_devolucao = devolucao.guia_devolucao
    guia_pagamento = guia_devolucao.guia_pagamento if guia_devolucao.present?
    cliente        = guia_pagamento.cliente        if guia_pagamento.present? 
    guia[:cliente] = cliente.nome if cliente.present?
    guia[:valor_guia]  = guia_pagamento.valor_debito if guia_pagamento.present? 
    guia[:tipo_debito] = descricao_de(guia_pagamento.debito_tipo) if guia_pagamento.present? 
    
    complemento(guia, devolucao)
  end

  def preenche_debito(devolucao)
    debito = {}

    debito[:tipo_debito]   = descricao_de devolucao.debito_tipo
    debito[:valor_cobrado] = devolucao.aviso_bancario.valor_contabilizado if devolucao.aviso_bancario.present? 

    complemento(debito, devolucao)
  end

  def preenche_valores(devolucao)
    valores = {}

    valores[:cliente] = devolucao.cliente.nome if devolucao.cliente.present?

    guia_devolucao = devolucao.guia_devolucao
    valores[:tipo_debito] = descricao_de devolucao.debito_tipo
    valores[:valor_guia]  = guia_devolucao.valor_devolucao if guia_devolucao.present?

    complemento(valores, devolucao)
  end

  def complemento(dados={}, devolucao)
    dados[:valor_devolucao] = devolucao.valor_devolucao
    dados[:data_devolucao] = devolucao.data_devolucao

    situacao_anterior = devolucao.situacao_devolucao_anterior
    dados[:situacao_anterior] = situacao_anterior.descricao_abreviada if situacao_anterior.present?
    dados[:situacao_anterior_dica] = descricao_de situacao_anterior

    situacao_atual = devolucao.situacao_devolucao_atual
    dados[:situacao_atual]    = situacao_atual.descricao_abreviada if situacao_atual.present?
    dados[:situacao_atual_dica] = descricao_de situacao_atual

    dados
  end
end