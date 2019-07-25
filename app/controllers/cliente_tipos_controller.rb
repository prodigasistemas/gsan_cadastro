class ClienteTiposController < ApplicationController
  before_action :set_cliente_tipo, only: [:show, :update]

  def index
    if params[:query]
      query = params[:query].deep_symbolize_keys
      @cliente_tipos = ClienteTipo.com_dados.filter(query)

      unless params[:paginado] == "false"
        @total = @cliente_tipos.count
        @cliente_tipos = @cliente_tipos.page(params[:page]).per(params[:per] || 20)
      end
    else
      @cliente_tipos = ClienteTipo.com_dados.all
    end
  end

  def show

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
    if @cliente_tipo.update cliente_tipo_params
      render json: {}
    else
      render json: { errors: @cliente_tipo.errors.full_messages }, status: 422
    end
  end

private

  def set_cliente_tipo
    @cliente_tipo = ClienteTipo.com_dados.find(params[:id])
  end

  def cliente_tipo_params
    params.require(:cliente_tipo).permit :descricao, :esfera_poder_id, :pessoa_fisica_juridica, :ativo
  end
end
