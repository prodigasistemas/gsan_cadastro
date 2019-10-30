class Atendimento::DevolucoesImoveisController < ImoveisController
  private

  def busca_imovel
    @imovel = Atendimento::DevolucoesImovel.com_escopo([:logradouro]).find(params[:id])
  end

  def inclusoes
    super << :devolucoes
  end
end