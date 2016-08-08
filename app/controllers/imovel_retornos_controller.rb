class ImovelRetornosController < ApplicationController
  def index
    @imovel_retornos = ImovelRetorno.buscar params.require(:query).permit! if params[:query].present?
    @imovel_retornos ||= ImovelRetorno.all

    if @imovel_retornos.any?
      render json: { entidades: @imovel_retornos.map(&:atributos) }, status: :ok
    else
      render json: { entidades: [] }, status: :ok
    end
  end
end