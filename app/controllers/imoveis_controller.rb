class ImoveisController < ApplicationController
  def index
    if params[:query].present?
      query = params[:query].deep_symbolize_keys
      @imoveis = Imovel.where(query)
    end

    if @imoveis
      render json: {entidades: @imoveis.map {|imovel| imovel.atributos([:localidade, :setor_comercial])}}, status: :ok
    else
      render json: { entidades: [] }, status: :ok
    end
  end
end