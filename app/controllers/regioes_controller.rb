class RegioesController < ApplicationController
  def index
    if params[:query].present?
      query = params[:query].deep_symbolize_keys
      @regioes = Regiao.filter(query)
      @total = @regioes.count
      @regioes = @regioes.page(params[:page]).per(20)
    else
      @regioes = Regiao.all
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

  private
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