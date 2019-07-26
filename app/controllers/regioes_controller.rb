class RegioesController < ApplicationController
  before_action :set_regiao, only: [:show, :update]

  def index
    if params[:query].present?
      query = params[:query]
      @regioes = Regiao.filter(query).order(:nome)
      @total = @regioes.count
      @regioes = @regioes.page(params[:page]).per(20)
    else
      @regioes = Regiao.all.order(:nome)
    end
  end

  def create
    @regiao = Regiao.new regiao_params
    if @regiao.save
      render :show
    else
      render_erros
    end
  end

  def show

  end

  def update
    if @regiao.update_attributes(regiao_params)
      render :show
    else
      render_erros
    end
  end

private

  def set_regiao
    @regiao = Regiao.find params[:id]
  end

  def regiao_params
    params.require(:regiao)
      .permit(
        :nome,
        :ativo
      )
  end

  def render_erros
    render json: {
      errors: @regiao.errors.full_messages
    }, status: 422
  end
end