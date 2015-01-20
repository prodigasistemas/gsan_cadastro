class ClientesController < ApplicationController
  def index
    if params[:query]
      query = params[:query].deep_symbolize_keys
      @clientes = Cliente.filter(query)
      @total = @clientes.size
      @clientes = @clientes.page(params[:page]).per(20)
    else
      @clientes = Cliente.join.page(params[:page]).per(20)
    end
  end

  def create
    @cliente = Cliente.new cliente_params

    if @cliente.save
      render json: {}, status: :ok
    else
      render json: { errors: @cliente.errors.full_messages }, status: 422
    end
  end

  private

  def cliente_params
    params.require(:cliente).permit(:nome, :ativo, :cliente_tipo_id)
  end
end
