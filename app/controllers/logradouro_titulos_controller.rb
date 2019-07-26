class LogradouroTitulosController < ApplicationController
  def index
    if params[:query]
      query = params[:query]
      @logradouro_titulos = LogradouroTitulo.order(:descricao).filter(query)

      unless params[:paginado] == "false"
        @total = @logradouro_titulos.count
        @logradouro_titulos = @logradouro_titulos.page(params[:page]).per(params[:per] || 20)
      end
    else
      @logradouro_titulos = LogradouroTitulo.order(:descricao).all
    end
  end

  def show
    @logradouro_titulo = LogradouroTitulo.find(params[:id])
  end

  def create
    @logradouro_titulo = LogradouroTitulo.new(logradouro_titulo_params)

    if @logradouro_titulo.save
      render :show
    else
      render json: { errors: @logradouro_titulo.errors.full_messages }, status: 422
    end
  end

  def update
    @logradouro_titulo = LogradouroTitulo.find(params[:id])

    if @logradouro_titulo.update logradouro_titulo_params
      render json: {}
    else
      render json: { errors: @logradouro_titulo.errors.full_messages }, status: 422
    end
  end

  private

  def logradouro_titulo_params
    params.require(:logradouro_titulo).permit  :descricao, :descricao_abreviada, :descricao_abreviada_completa, :ativo
  end
end
