class AbrangenciasController < ApplicationController
  def index
    @abrangencias = Abrangencia.buscar params.require(:query).permit! if params[:query].present?
    @abrangencias ||= Abrangencia.all

    if @abrangencias.any?
      render json: { entidades: @abrangencias.map(&:atributos) }, status: :ok
    else
      render json: { entidades: [] }, status: :ok
    end
  end

  def create
    @contrato_medicao = ContratoMedicao.find(params[:contrato_medicao_id])

    query = Imovel.check_params(params.require(:query).permit!).symbolize_keys
    imoveis = Imovel.buscar(query).ids if query.present?

    abrangencia_attrs = Abrangencia.criar(@contrato_medicao, imoveis)

    if @contrato_medicao.imoveis.count >= abrangencia_attrs.size
      render json: { entidade: @contrato_medicao.atributos }, status: :ok
    else
      render json: { errors: @contrato_medicao.errors }, status: :unprocessable_entity
    end
  end

  def redefinir
    @contrato_medicao = ContratoMedicao.find(params[:contrato_medicao_id])

    if @contrato_medicao.redefinir
      render json: { entidade: @contrato_medicao.atributos }, status: :ok
    else
      render json: { errors: @contrato_medicao.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @abrangencia = Abrangencia.find params[:id]

    if @abrangencia.excluir
      render json: { }, status: :ok
    else
      render json: { errors: @abrangencia.errors }, status: :unprocessable_entity
    end
  end

  protected

  def abrangencia_params
    params.permit([:contrato_medicao_id, query: [ :id, :localidade_id, :setor_comercial_id, :qdra_id]])
  end
end