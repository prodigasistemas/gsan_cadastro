class CepsController < ApplicationController
  def index
    @ceps = Cep.last(100)
  end

  def show
    @cep = Cep.find(params[:id])
  end

  def create
    @cep = Cep.new(cep_params)

    if @cep.save
      render :show
    else
      render json: { errors: @cep.errors.full_messages }, status: 422
    end
  end

  private

  def cep_params
    params.require(:cep).permit(:municipio, :codigo, :uf, :bairro)
  end
end
