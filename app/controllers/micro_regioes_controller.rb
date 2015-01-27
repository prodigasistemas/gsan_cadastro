class MicroRegioesController < ApplicationController
  before_action :set_micro_regiao, only: [:show, :update]

  def index
    if params[:query].present?
      query = params[:query].deep_symbolize_keys
      @micro_regioes = MicroRegiao.join.filter(query)
      @total = @micro_regioes.count
      @micro_regioes = @micro_regioes.page(params[:page]).per(20)
    else
      @micro_regioes = MicroRegiao.join.ativos
    end
  end
  
  def show

  end

  def create
    @micro_regiao = MicroRegiao.new micro_regiao_params
    @micro_regiao.regiao = get_regiao

    if @micro_regiao.save
      render :show
    else
      render_erros
    end
  end

  def update
    @micro_regiao = MicroRegiao.find params[:id]
    @micro_regiao.regiao = get_regiao

    if @micro_regiao.update_attributes(micro_regiao_params)
      render :show
    else
      render_erros
    end
  end
  
private

  def set_micro_regiao
    @micro_regiao = MicroRegiao.join.find params[:id]
  end
  
  def micro_regiao_params
    params.require(:micro_regiao)
      .permit(
        :nome, 
        :regiao_id, 
        :ativo
      )
  end

  def get_regiao
    Regiao.find micro_regiao_id if micro_regiao_id.present?
  end

  def micro_regiao_id
    micro_regiao_params[:regiao_id]
  end

  def render_erros
    render json: {
      errors: @micro_regiao.errors.full_messages 
    }, status: 422
  end
end
