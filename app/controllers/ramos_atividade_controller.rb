class RamosAtividadeController < ApplicationController
  def index
    if params[:query]
      query = params[:query]
      @ramos_atividade = RamoAtividade.order(:descricao).filter_data(query)

      unless params[:paginado] == "false"
        @total = @ramos_atividade.count
        @ramos_atividade = @ramos_atividade.page(params[:page]).per(params[:per] || 20)
      end
    else
      @ramos_atividade = RamoAtividade.order(:descricao).all
    end
  end

  def show
    @ramo_atividade = RamoAtividade.find(params[:id])
  end

  def create
    @ramo_atividade = RamoAtividade.new(ramo_atividade_params)

    if @ramo_atividade.save
      render :show
    else
      render json: { errors: @ramo_atividade.errors.full_messages }, status: 422
    end
  end

  def update
    @ramo_atividade = RamoAtividade.find(params[:id])

    if @ramo_atividade.update ramo_atividade_params
      render json: {}
    else
      render json: { errors: @ramo_atividade.errors.full_messages }, status: 422
    end
  end

  private

  def ramo_atividade_params
    params.require(:ramo_atividade).permit  :descricao,
                                            :codigo,
                                            :ativo
  end
end
