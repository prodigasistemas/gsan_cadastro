class MunicipiosController < ApplicationController
  def index
    if params[:query]
      query = params[:query].deep_symbolize_keys
      query[:nome] = nil

      @municipios = Municipio
        .includes(:uf, :micro_regiao, :regiao_desenvolvimento)
        .joins(:uf, :micro_regiao, :regiao_desenvolvimento)
        .where(query.reject! { |k,v| v.blank? })
      @municipios = @municipios.where("UPPER(muni_nmmunicipio) LIKE ?", "%#{params[:query][:nome].upcase}%") if params[:query][:nome]

      @total = @municipios.count
      @municipios = @municipios.page(params[:page]).per(20)
    else
      @municipios = Municipio
        .includes(:uf, :micro_regiao, :regiao_desenvolvimento)
        .joins(:uf, :micro_regiao, :regiao_desenvolvimento)
        .all
    end
  end

  def show
    @municipio = Municipio.find(params[:id])
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
    @municipio = Municipio.find(params[:id])

    if @municipio.update municipio_params
      render :show
    else
      render json: { errors: @municipio.errors.full_messages }, status: 422
    end
  end

  private

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
