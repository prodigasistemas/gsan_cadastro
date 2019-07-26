class ProfissoesController < ApplicationController
  def index
    if params[:query]
      query = params[:query]
      @profissoes = Profissao.order(:descricao).filter(query)

      unless params[:paginado] == "false"
        @total = @profissoes.count
        @profissoes = @profissoes.page(params[:page]).per(params[:per] || 20)
      end
    else
      @profissoes = Profissao.order(:descricao).all
    end
  end

  def show
    @profissao = Profissao.find(params[:id])
  end

  def create
    @profissao = Profissao.new(profissao_params)

    if @profissao.save
      render :show
    else
      render json: { errors: @profissao.errors.full_messages }, status: 422
    end
  end

  def update
    @profissao = Profissao.find(params[:id])

    if @profissao.update profissao_params
      render json: {}
    else
      render json: { errors: @profissao.errors.full_messages }, status: 422
    end
  end

  private

  def profissao_params
    params.require(:profissao).permit :descricao,
                                          :codigo,
                                          :ativo
  end
end
