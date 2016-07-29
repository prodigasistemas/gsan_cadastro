class RotasController < ApplicationController
  def index
    @rotas = Rota.setor_comercial_id(params[:filtros][:setor_comercial_id])

    render json: { entidades: @rotas.map(&:atributos) }
  end
end