class Atendimento::HistoricoFaturamento < Imovel
  def historico_faturamento
    cadastro = {}

    cadastro[:contas] = get_historico_contas

    cadastro
  end

  private 

  def get_historico_contas
    dados = []

    self.contas.map do |conta|
      c = {}

      agua     = conta.valor_agua     ||= 0
      esgoto   = conta.valor_esgoto   ||= 0
      debitos  = conta.valor_debitos  ||= 0
      creditos = conta.valor_creditos ||= 0
      impostos = conta.valor_impostos ||= 0

      c[:mes_ano]    = conta.ano_mes_referencia 
      c[:vencimento] = conta.data_vencimento
      c[:agua]       = agua
      c[:esgoto]     = esgoto
      c[:debitos]    = debitos
      c[:creditos]   = creditos
      c[:impostos]   = impostos
      c[:total]      = (agua + esgoto + debitos) - (creditos + impostos)
      c[:situacao_dica] = descricao_de conta.debito_credito_situacao

      situacao = conta.debito_credito_situacao
      c[:situacao]   = situacao.present?? situacao.abreviada : situacao

      dados << c
    end

    dados
  end
end