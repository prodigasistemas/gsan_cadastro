class Atendimento::ParcelamentosController < ImoveisController
  private

  def busca_imovel
    @imovel = Atendimento::Parcelamento.com_escopo([:logradouro]).find(params[:id])
  end

  def inclusoes
    super << :parcelamentos_efetuados
  end
end