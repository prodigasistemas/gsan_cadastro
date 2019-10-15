class Atendimento::DebitosImovel < Imovel
  def debitos_imovel
    cadastro = {}

    cadastro[:situacoes_cobranca] = get_situacoes_cobranca

    cadastro
  end

  private

  def get_situacoes_cobranca
    dados = []

    situacoes = self.imovel_cobrancas_situacoes.includes(:cobranca_situacao).where(data_retirada: nil)
    
    return dados unless situacoes.present?

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