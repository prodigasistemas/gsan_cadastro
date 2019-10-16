class Atendimento::DebitosImovel < Imovel
  def debitos_imovel
    cadastro = {}

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

end