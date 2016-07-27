class ImoveisController < ApplicationController
  def index
    @imoveis = Imovel.com_dados.buscar(params[:query]) if params[:query].present?
    @imoveis ||= Imovel.all

    if @imoveis.any?
      render json: {entidades: @imoveis.map(&:atributos_busca)}, status: :ok
    else
      render json: { entidades: [] }, status: :ok
    end
  end
end