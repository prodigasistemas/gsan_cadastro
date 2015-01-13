class CepsController < ApplicationController
  def index
    @ceps = Cep.last(100)
  end

  def show
    @cep = Cep.find(params[:id])
  end

  def create
    @municipio = Municipio.find_by(id: params[:cep][:muni_id])
    cep_params = cep_params.merge(municipio: @municipio.nome) if @municipio
    @cep = Cep.new(cep_params)

    if @cep.save
      render :show
    else
      render json: { errors: @cep.errors.full_messages }, status: 422
    end
  end

  private

  def cep_params
    params.require(:cep).permit(:ativo,
                                :bairro,
                                :codigo,
                                :intervalo,
                                :logradouro,
                                :municipio,
                                :tipo_id,
                                :tipo_logradouro,
                                :uf)
  end
end
