class Atendimento::AnaliseLigacaoConsumosController < ImoveisController
    private
  
    def busca_imovel
      @imovel = Atendimento::AnaliseLigacaoConsumo.com_escopo([:logradouro]).find(params[:id])
    end
  
    def inclusoes
      super << :analise_consumo
    end
  end