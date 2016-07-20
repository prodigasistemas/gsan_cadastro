class LocalidadesController < ApplicationController
  def index
    @localidades = Localidade.all

    if @localidades
      render json: { entidades: @localidades }, status: :ok
    else
      render json: { entidades: [] }, status: :ok
    end
  end
end