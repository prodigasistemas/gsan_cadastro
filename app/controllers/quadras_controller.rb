class QuadrasController < ApplicationController
  def index
    @quadras = Quadra.setor_comercial_id(params[:filtros][:setor_comercial_id])

    render json: { entidades: @quadras.map(&:atributos) }
  end
end