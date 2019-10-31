class Atendimento::RegistrosAtendimentosController < ImoveisController
  private

  def busca_imovel
    @imovel = Atendimento::RegistroAtendimento.com_escopo([:logradouro]).find(params[:id])
  end

  def inclusoes
    super << :registros_atendimentos
  end
end