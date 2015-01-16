class BairrosController < ApplicationController
  def index
    if params[:query]
      query = params[:query].deep_symbolize_keys
      query[:nome] = nil
      
      @bairros = Bairro.includes(:municipio).where(query.reject! { |k, v| v.blank? })
      @bairros = @bairros.where("UPPER(bair_nmbairro) LIKE ?", "%#{params[:query][:nome].upcase}%") if params[:query][:nome]
      
      @total = @bairros.count
      @bairros = @bairros.page(params[:page]).per(20)
    else
      @bairros = Bairro.includes(:municipio).all
    end
  end

  def show
    @bairro = Bairro.find(params[:id])
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
    @bairro = Bairro.find(params[:id])

    if @bairro.update bairro_params
      render :show
    else
      render json: { errors: @bairro.errors.full_messages }, status: 422
    end
  end

  private

  def bairro_params
    params.require(:bairro).permit  :nome,
                                    :codigo,
                                    :codigo_prefeitura,
                                    :municipio_id,
                                    :ativo

  end
end
