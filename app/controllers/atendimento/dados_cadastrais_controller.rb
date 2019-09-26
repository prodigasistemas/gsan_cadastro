class Atendimento::DadosCadastraisController < ImoveisController
  private

  def busca_imovel
    @imovel = Atendimento::DadosCadastral.com_escopo([:logradouro]).find(params[:id])
  end

  def inclusoes
    super << :dados_cadastrais
  end
end
