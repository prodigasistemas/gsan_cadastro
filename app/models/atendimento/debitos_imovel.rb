class Atendimento::DebitosImovel < Imovel
  def debitos_imovel
    cadastro = {}

    cadastro[:contas] = get_contas_inconformes
    cadastro[:situacoes_cobranca]     = get_situacoes_cobranca
    cadastro[:historico_negativacoes] = get_historico_negativacoes

    cadastro
  end

  private

  def get_historico_negativacoes
    dados = []
    
    negativacoes = NegativadorMovimentoRegistroRetornoMotivo.por_imovel(self.id)
    negativacoes.map do |negativacao|
      n = {}
      
      n[:data]        = negativacao.negativador_movimento_reg.negativador_movimento.data_retorno
      n[:motivo]      = descricao_de negativacao.negativador_retorno_motivo
      n[:situacao]    = negativacao.negativador_movimento_reg.indicador_correcao
      
      negativador = negativacao.negativador_movimento_reg.negativador_movimento.negativador.cliente
      n[:negativador] = negativador.present?? negativador.nome : negativador 
      
      dados << n
    end

    dados
  end  

  def get_situacoes_cobranca
    dados = []

    situacoes = self.imovel_cobrancas_situacoes.includes(:cobranca_situacao).where(data_retirada: nil)
    situacoes.map do |situacao|          
      s = {}
      s[:id]               = situacao.id
      s[:codigo]           = situacao.cobranca_situacao_id
      s[:descricao]        = descricao_de situacao.cobranca_situacao
      s[:data_implantacao] = situacao.data_implantacao

      dados << s
    end

    dados
  end

  def get_contas_inconformes
    debitos_imoveis = []

    pagamentos.map do |pagamento|
      p = {}
      p[:valor_pagamento] = 0
      p[:valor_pagamento] = pagamento.valor_pagamento
      p[:ano_mes_referencia] = pagamento.ano_mes_referencia
      p[:data_pagamento] = pagamento.data_pagamento
      p[:valor_conta] = 0
      if pagamento.conta.present?
        p[:valor_conta] = pagamento.conta.valor_creditos + pagamento.conta.valor_debitos + pagamento.conta.valor_esgoto + pagamento.conta.valor_agua
      end
      if pagamento.situacao_pagamento_atual.present?
        p[:situacao_atual] = pagamento.situacao_pagamento_atual.descricao
      end
      if pagamento.situacao_pagamento_anterior.present?
        p[:situacao_anterior] = pagamento.situacao_pagamento_anterior.descricao
      end
      debitos_imoveis << p
    end

    debitos_imoveis
  end
end