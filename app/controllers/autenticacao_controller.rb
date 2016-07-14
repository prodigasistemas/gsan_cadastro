class AutenticacaoController < ApplicationController
  def create
    @usuario = Usuario.login params[:login], params[:senha]
    if @usuario
      render json: { mensagem: 'Autenticacao realizada com sucesso!', usuario: @usuario.attributes }, status: :ok
    else
      render json: { }, status: :unauthorized
    end
  end
end