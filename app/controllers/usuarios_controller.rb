class UsuariosController < ApplicationController
  def show
    @usuario = Usuario.find params[:id]

    if @usuario
      render json: { usuario: @usuario.attributes }, status: :ok
    else
      render json: { }, status: :not_found
    end
  end
end