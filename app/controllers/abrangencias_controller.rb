class  AbrangenciasController < ApplicationController
  def index
  end

  def create
    @contrato_medicao = ContratoMedicao.find(params[:contrato_medicao_id])
    imoveis = Imovel.where(id: params[:imoveis])
    @contrato_medicao.imoveis = imoveis

    if @contrato_medicao.save
      render json: { status: true }, status: :ok
    else
      render json: { status: false }, status: :unprocessable_entity
    end
  end

  protected

  def abrangencia_params
    params.permit([:contrato_medicao_id, :imoveis])
  end
end