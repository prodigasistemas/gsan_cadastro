class CepTiposController < ApplicationController
  def index
    if params[:query].present?
      query = params[:query]
      @cep_tipos = CepTipo.filter(query)
      @total = @cep_tipos.count
      @cep_tipos = @cep_tipos.page(params[:page]).per(20)
    else
      @cep_tipos = CepTipo.ativo.order(descricao: :asc)
    end
  end

  def show
    @cep_tipo = CepTipo.find params[:id]
  end

  def create
    @cep_tipo = CepTipo.new cep_tipo_params
    if @cep_tipo.save
      render :show
    else
      render_errors
    end
  end

  def update
    @cep_tipo = CepTipo.find params[:id]

    if @cep_tipo.update(cep_tipo_params)
      render :show
    else
      render_errors
    end
  end

  private
  def cep_tipo_params
    params.require(:cep_tipo).permit :descricao, :ativo
  end

  def render_errors
    render json: { errors: @cep_tipo.errors.full_messages }, status: 422
  end
end
