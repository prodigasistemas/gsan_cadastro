class UsuariosController < ApplicationController
  def index
    @usuarios = Usuario.all
    if @usuarios.blank?
      render json: { }, status: :not_found
    else
      render json: { entidades: @usuarios.map(&:atributos) }, status: :ok
    end
  end

  def show
    @usuario = Usuario.find params[:id]

    if @usuario
      render json: { entidade: @usuario.atributos }, status: :ok
    else
      render json: { }, status: :not_found
    end
  end
end