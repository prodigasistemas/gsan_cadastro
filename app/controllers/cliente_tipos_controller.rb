class ClienteTiposController < ApplicationController
  def index
    if params[:query]
      query = params[:query].deep_symbolize_keys
      @cliente_tipos = ClienteTipo.order(:descricao).filter(query)

      unless params[:paginado] == "false"
        @total = @cliente_tipos.count
        @cliente_tipos = @cliente_tipos.page(params[:page]).per(params[:per] || 20)
      end
    else
      @cliente_tipos = ClienteTipo.order(:descricao).all
    end
  end

  def show
    @cliente_tipo = ClienteTipo.find(params[:id])
  end

  def create
    @cliente_tipo = ClienteTipo.new(cliente_tipo_params)

    if @cliente_tipo.save
      render :show
    else
      render json: { errors: @cliente_tipo.errors.full_messages }, status: 422
    end
  end

  def update
    @cliente_tipo = ClienteTipo.find(params[:id])

    if @cliente_tipo.update cliente_tipo_params
      render json: {}
    else
      render json: { errors: @cliente_tipo.errors.full_messages }, status: 422
    end
  end

  private

  def cliente_tipo_params
    params.require(:cliente_tipo).permit :descricao, :esfera_poder_id, :pessoa_fisica_juridica, :ativo
  end
end
