class AutenticacaoController < ApplicationController
  def create
    @usuario = Usuario.login params[:login], params[:senha]
    if @usuario
      render json: { mensagem: 'Autenticacao realizada com sucesso!', usuario: @usuario.attributes }, status: :ok
    else
      render json: { mensagem: 'Falha ao autenticar usuario!', usuario: nil }, status: :ok
    end
  end
end