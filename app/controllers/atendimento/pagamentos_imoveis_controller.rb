class Atendimento::PagamentosImoveisController < ImoveisController
  private

  def busca_imovel
    @imovel = Atendimento::PagamentosImovel.com_escopo([:logradouro]).find(params[:id])
  end

  def inclusoes
    super << :pagamentos
  end
end