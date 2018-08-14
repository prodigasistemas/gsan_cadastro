class ImovelControleAtualizacaoCadastraisController < ApplicationController

  before_action :find_imovel_controle_atualizacao_cadastral

  def show
    @imovel_controle_atualizacao_cadastral = ImovelControleAtualizacaoCadastral.find_by(imovel_id: params[:id]) if @imovel_controle_atualizacao_cadastral.nil?
    if @imovel_controle_atualizacao_cadastral
      render json: { entidade: @imovel_controle_atualizacao_cadastral.atributos }, status: :ok
    else
      render json: {}, status: :not_found
    end
  end

  def update
    if @imovel_controle_atualizacao_cadastral.atualizar(imovel_controle_atualizacao_cadastral_params[:situacao_atualizacao_cadastral_id],
                                                        imovel_controle_atualizacao_cadastral_params[:revisoes] || [])
      render json: { entidade: @imovel_controle_atualizacao_cadastral.atributos }, status: :ok
    else
      render json: {}, status: :not_found
    end
  end

  private

    def find_imovel_controle_atualizacao_cadastral
      @imovel_controle_atualizacao_cadastral = ImovelControleAtualizacaoCadastral.find_by_id params[:id]
    end

    def imovel_controle_atualizacao_cadastral_params
      params.require(:imovel_controle_atualizacao_cadastral).permit(:id, :imovel_id, :situacao_atualizacao_cadastral_id, :revisoes => [])
    end

end
