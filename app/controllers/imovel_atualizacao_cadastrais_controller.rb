class ImovelAtualizacaoCadastraisController < ApplicationController

  before_action :find_imovel_atualizacao_cadastral

  def update
    if @imovel_atualizacao_cadastral.update imovel_atualizacao_cadastral_params
      render json: { entidade: @imovel_atualizacao_cadastral.atributos }, status: :ok
    else
      render json: {}, status: :not_found
    end
  end

  def show
    if @imovel_atualizacao_cadastral
      render json: { entidade: @imovel_atualizacao_cadastral.atributos }, status: :ok
    else
      render json: {}, status: :not_found
    end
  end

  private

    def find_imovel_atualizacao_cadastral
      @imovel_atualizacao_cadastral = ImovelAtualizacaoCadastral.find_by_id params[:id]
    end

    def imovel_atualizacao_cadastral_params
      params.require(:imovel_atualizacao_cadastral).permit(:id, :codigo_imovel, :situacao_cadastral_id)
    end
end
