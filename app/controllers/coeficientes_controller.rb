class CoeficientesController < ApplicationController

  def show
    @coeficiente = Coeficiente.find params[:id]

    if @coeficiente
      render json: {entidade: @coeficiente.atributos}, status: :ok
    else
      render json: {}, status: :not_found
    end
  end

  def create
    @coeficiente = Coeficiente.new coeficiente_params

    if @coeficiente.save
      render json: { entidade: @coeficiente.atributos }, status: :ok
    else
      render json: { errors: @coeficiente.errors }, status: :unprocessable_entity
    end
  end

  def update
    @coeficiente = Coeficiente.find params[:id]
    binding.pry
    if @coeficiente.update coeficiente_params
      render json: { entidade: @coeficiente.atributos }, status: :ok
    else
      render json: { errors: @coeficiente.errors }, status: :unprocessable_entity
    end
  end

  protected

  def coeficiente_params
    params.require(:coeficiente).permit(:ligacao_agua_id, :coeficiente, :contrato_medicao_id)
  end
end
