class CoeficientesController < ApplicationController

  def index
    @coeficientes = Coeficiente.all

    if @coeficientes
      render json: {entidades: @coeficientes.map(&:atributos)}, status: :ok
    else
      render json: {entidades: []}, status: :ok
    end
  end

  def show
    @coeficiente = Coeficiente.find params[:id]

    if @coeficiente
      render json: {entidade: @coeficiente.atributos}, status: :ok
    else
      render json: {}, status: :not_found
    end
  end

  def create
    if Coeficiente.create(coeficiente_params_for_create[:coeficientes])
      render json: { entidade: Coeficiente.last.atributos }, status: :ok
    else
      render json: { errors: @coeficiente.errors }, status: :unprocessable_entity
    end
  end

  def update
    @coeficiente = Coeficiente.find params[:id]

    if @coeficiente.update coeficiente_params_for_update
      render json: { entidade: @coeficiente.atributos }, status: :ok
    else
      render json: { errors: @coeficiente.errors }, status: :unprocessable_entity
    end
  end

  protected

  def coeficiente_params_for_create
    params.require(:coeficiente).permit(
      coeficientes: [:contrato_medicao_id, :ligacao_agua_id, :coeficiente, :usuario_id]
    )
  end

  def coeficiente_params_for_update
    params.require(:coeficiente).permit(:ligacao_agua_id, :coeficiente, :contrato_medicao_id, :usuario_id)
  end
end
