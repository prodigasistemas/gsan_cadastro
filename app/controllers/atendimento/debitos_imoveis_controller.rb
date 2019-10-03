class Atendimento::DebitosImoveisController < ImoveisController
  private

  def busca_imovel
    @imovel = Atendimento::DebitosImovel.com_escopo([:logradouro]).find(params[:id])
  end

  def inclusoes
    super << :debitos_imovel
  end
end