class LogradouroTiposController < ApplicationController
  def index
    if params[:query]
      query = params[:query]
      @logradouro_tipos = LogradouroTipo.order(:descricao).filtrar_campos(query)

      unless params[:paginado] == "false"
        @total = @logradouro_tipos.count
        @logradouro_tipos = @logradouro_tipos.page(params[:page]).per(params[:per] || 20)
      end
    else
      @logradouro_tipos = LogradouroTipo.order(:descricao).all
    end
  end

  def show
    @logradouro_tipo = LogradouroTipo.find(params[:id])
  end

  def create
    @logradouro_tipo = LogradouroTipo.new(logradouro_tipo_params)

    if @logradouro_tipo.save
      render :show
    else
      render json: { errors: @logradouro_tipo.errors.full_messages }, status: 422
    end
  end

  def update
    @logradouro_tipo = LogradouroTipo.find(params[:id])

    if @logradouro_tipo.update logradouro_tipo_params
      render json: {}
    else
      render json: { errors: @logradouro_tipo.errors.full_messages }, status: 422
    end
  end

  private

  def logradouro_tipo_params
    params.require(:logradouro_tipo).permit  :descricao, :descricao_abreviada, :descricao_abreviada_completa, :ativo
  end
end
