class EsferasPoderController < ApplicationController
  def index
    if params[:query]
      query = params[:query]
      @esferas = EsferaPoder.order(:descricao).filtrar_campos(query)

      unless params[:paginado] == "false"
        @total = @esferas.count
        @esferas = @esferas.page(params[:page]).per(params[:per] || 20)
      end
    else
      @esferas = EsferaPoder.order(:descricao).all
    end
  end

  def show
    @esfera = EsferaPoder.find(params[:id])
  end

  def create
    @esfera = EsferaPoder.new(esfera_poder_params)

    if @esfera.save
      render :show
    else
      render json: { errors: @esfera.errors.full_messages }, status: 422
    end
  end

  def update
    @esfera = EsferaPoder.find(params[:id])

    if @esfera.update esfera_poder_params
      render json: {}
    else
      render json: { errors: @esfera.errors.full_messages }, status: 422
    end
  end

  private

  def esfera_poder_params
    params.require(:esfera_poder).permit :descricao,
                                          :permite_gerar_certidao_negativa_imovel,
                                          :permite_gerar_certidao_negativa_cliente,
                                          :ativo
  end
end
