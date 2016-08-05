class SetorComercialController < ApplicationController
  def index
    @setores = SetorComercial.localidade_id(params[:filtros][:localidade_id])

    render json: { entidades: @setores.map(&:atributos) }
  end
end