class MicroRegioesController < ApplicationController
  def index
    @micro_regioes = MicroRegiao.ativos
  end
  
  def create
    @micro_regiao = MicroRegiao.new micro_regiao_params
    @micro_regiao.regiao = get_regiao

    if @micro_regiao.save
      render :show
    else
      render json: { 
        errors: @micro_regiao.errors.full_messages 
      }, status: 422
    end
  end
  
  private
  
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
end
