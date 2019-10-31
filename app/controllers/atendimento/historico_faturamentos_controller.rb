class Atendimento::HistoricoFaturamentosController < ImoveisController
  private

  def busca_imovel
    @imovel = Atendimento::HistoricoFaturamento.com_escopo([:logradouro]).find(params[:id])
  end

  def inclusoes
    super << :historico_faturamento
  end
end