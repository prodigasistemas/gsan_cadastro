class EnderecoTiposController < ApplicationController
  def index
    if params[:query]
      query = params[:query]
      @endereco_tipos = EnderecoTipo.order(:descricao).filter_data(query)

      unless params[:paginado] == "false"
        @total = @endereco_tipos.count
        @endereco_tipos = @endereco_tipos.page(params[:page]).per(params[:per] || 20)
      end
    else
      @endereco_tipos = EnderecoTipo.order(:descricao).all
    end
  end

  def show
    @endereco_tipo = EnderecoTipo.find(params[:id])
  end

  def create
    @endereco_tipo = EnderecoTipo.new(endereco_tipo_params)

    if @endereco_tipo.save
      render :show
    else
      render json: { errors: @endereco_tipo.errors.full_messages }, status: 422
    end
  end

  def update
    @endereco_tipo = EnderecoTipo.find(params[:id])

    if @endereco_tipo.update endereco_tipo_params
      render json: {}
    else
      render json: { errors: @endereco_tipo.errors.full_messages }, status: 422
    end
  end

  private

  def endereco_tipo_params
    params.require(:endereco_tipo).permit  :descricao,
                                            :ativo
  end
end
