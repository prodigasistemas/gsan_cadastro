class BairrosController < ApplicationController
  before_action :set_bairro, only: [:show, :update]

  def index
    if params[:query]
      query = params[:query].deep_symbolize_keys
      @bairros = Bairro.join.filter(query)
      
      unless params[:paginado] == "false"
        @total = @bairros.count
        @bairros = @bairros.page(params[:page]).per(params[:per] || 20)
      end
    else
      @bairros = Bairro.join.all
    end
  end

  def show
    
  end

  def create
    @bairro = Bairro.new(bairro_params)

    if @bairro.save
      render :show
    else
      render json: { errors: @bairro.errors.full_messages }, status: 422
    end
  end

  def update
    if @bairro.update bairro_params
      render :show
    else
      render json: { errors: @bairro.errors.full_messages }, status: 422
    end
  end

private

  def set_bairro
    @bairro = Bairro.join.find(params[:id])
  end

  def bairro_params
    params.require(:bairro).permit  :nome,
                                    :codigo,
                                    :codigo_prefeitura,
                                    :municipio_id,
                                    :ativo,
                                    bairro_areas_attributes: [:id, :distrito_operacional_id, :nome, :_destroy]

  end
end
