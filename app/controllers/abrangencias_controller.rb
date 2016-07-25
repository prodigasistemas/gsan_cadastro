class AbrangenciasController < ApplicationController
  def index
    @abrangencias = Abrangencia.all

    if @abrangencias.any?
      render json: { entidades: @abrangencias.map(&:atributos) }, status: :ok
    else
      render json: { entidades: [], total: @total }, status: :ok
    end
  end

  def create
    @contrato_medicao = ContratoMedicao.find(params[:contrato_medicao_id])
    imoveis = Imovel.where(id: params[:imoveis])
    @contrato_medicao.imoveis << imoveis

    if @contrato_medicao.save
      render json: { entidade: @contrato_medicao.atributos }, status: :ok
    else
      render json: { errors: @contrato_medicao.errors }, status: :unprocessable_entity
    end
  end

  def redefinir
    @contrato_medicao = ContratoMedicao.find(params[:contrato_medicao_id])
    @contrato_medicao.imoveis = []

    if @contrato_medicao.save
      render json: { entidade: @contrato_medicao.atributos }, status: :ok
    else
      render json: { errors: @contrato_medicao.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @abrangencia = Abrangencia.find params[:id]
    if @abrangencia.destroy
      render json: { }, status: :ok
    else
      render json: { errors: @abrangencia.errors }, status: :unprocessable_entity
    end
  end

  def search
    search_params = params.require(:query).permit!.symbolize_keys
    @abrangencias = Abrangencia.where search_params

    if @abrangencias.any?
      render json: { entidades: @abrangencias.map(&:atributos) }, status: :ok
    else
      render json: { entidades: [] }, status: :ok
    end
  end

  protected

  def abrangencia_params
    params.permit([:contrato_medicao_id, :imoveis])
  end
end