class MunicipiosController < ApplicationController
  before_action :set_municipio, only: [:show, :update]

  def index
    if params[:query]
      query = params[:query]
      @municipios = Municipio.com_dados.filtrar_campos(query)
      @total = @municipios.count
      @municipios = @municipios.page(params[:page]).per(20)
    else
      @municipios = Municipio.com_dados.all
    end
  end

  def show

  end

  def create
    @municipio = Municipio.new(municipio_params)

    if @municipio.save
      render :show
    else
      render json: { errors: @municipio.errors.full_messages }, status: 422
    end
  end

  def update
    if @municipio.update municipio_params
      render :show
    else
      render json: { errors: @municipio.errors.full_messages }, status: 422
    end
  end

private

  def set_municipio
    @municipio = Municipio.com_dados.find(params[:id])
  end

  def municipio_params
    params.require(:municipio).permit :nome,
                                      :codigo_ibge,
                                      :quadro_bairro,
                                      :inicio_concessao, :fim_concessao,
                                      :cep_inicial, :cep_final,
                                      :ddd,
                                      :regiao_desenvolvimento_id,
                                      :micro_regiao_id,
                                      :uf_id,
                                      :ativo

  end
end
