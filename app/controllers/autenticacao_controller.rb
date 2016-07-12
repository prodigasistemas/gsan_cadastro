class AutenticacaoController < ApplicationController

  def create
    if Usuario.login params[:login], params[:senha]
      render json: { message: 'Autenticacao realizada com sucesso!' }, status: :ok
    else
      render json: { message: 'Falha ao autenticar usuario!' }, status: :unauthorized
    end
  end
end