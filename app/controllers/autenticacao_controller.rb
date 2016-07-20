class AutenticacaoController < ApplicationController
  def create
    @usuario = Usuario.login params[:nome_usuario], params[:senha]
    if @usuario
      render json: { mensagem: 'Autenticacao realizada com sucesso!', usuario: @usuario.atributos }, status: :ok
    else
      render json: { }, status: :unauthorized
    end
  end
end