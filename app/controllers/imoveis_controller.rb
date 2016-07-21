class ImoveisController < ApplicationController
  def index
    @imoveis = Imovel.buscar(params[:query]) if params[:query].present?

    if @imoveis
      render json: {entidades: @imoveis.map(&:atributos)}, status: :ok
    else
      render json: { entidades: [] }, status: :ok
    end
  end
end