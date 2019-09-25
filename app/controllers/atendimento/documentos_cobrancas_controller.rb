class Atendimento::DocumentosCobrancasController < ImoveisController
    private
  
    def busca_imovel
      @imovel = Atendimento::DocumentosCobranca.com_escopo([:logradouro]).find(params[:id])
    end
  
    def inclusoes
      super << :documentos_cobrancas
    end
  end