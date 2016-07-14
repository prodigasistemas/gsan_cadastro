class UsuariosController < ApplicationController
  def show
    @usuario = Usuario.find params[:id]

    if @usuario
      render json: { usuario: @usuario.attributes }, status: :ok
    else
      render json: { usuario: @usuario }, status: :ok
    end
  end
end