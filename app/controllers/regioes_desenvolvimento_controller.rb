class RegioesDesenvolvimentoController < ApplicationController
  before_action :set_regiao_desenvolvimento, only: [:show, :update]

  def index
    if params[:query]
      query = params[:query]
      @regioes_desenvolvimento = RegiaoDesenvolvimento.filtrar_campos(query)

      unless params[:paginado] == "false"
        @total = @regioes_desenvolvimento.count
        @regioes_desenvolvimento = @regioes_desenvolvimento.page(params[:page]).per(params[:per] || 20)
      end
    else
      @regioes_desenvolvimento = RegiaoDesenvolvimento.all
    end
  end

  def show

  end

  def create
    @regiao_desenvolvimento = RegiaoDesenvolvimento.new(regiao_desenvolvimento_params)

    if @regiao_desenvolvimento.save
      render :show
    else
      render json: { errors: @regiao_desenvolvimento.errors.full_messages }, status: 422
    end
  end

  def update
    if @regiao_desenvolvimento.update regiao_desenvolvimento_params
      render :show
    else
      render json: { errors: @regiao_desenvolvimento.errors.full_messages }, status: 422
    end
  end

  private

  def set_regiao_desenvolvimento
    @regiao_desenvolvimento = RegiaoDesenvolvimento.find(params[:id])
  end

  def regiao_desenvolvimento_params
    params.require(:regiao_desenvolvimento).permit :nome, :ativo
  end
end
