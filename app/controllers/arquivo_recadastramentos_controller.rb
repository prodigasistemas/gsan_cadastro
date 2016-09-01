class ArquivoRecadastramentosController < ApplicationController
  def show
    caminho ="#{Rails.root}/tmp/#{params[:nome_arquivo]}.csv"
    send_file caminho, :type=>"text/csv", :x_sendfile=>true
  end

  def verify
    nome = params[:nome_arquivo]
    caminho ="#{Rails.root}/tmp/#{nome}.csv"

    if File.exists?(caminho)
      render json: { success: true }, status: :ok
    else
      render json: { success: false }, status: :ok
    end
  end

  def create
    usuario = Usuario.find params[:usuario_id]

    if usuario.leituristas.present?
      @nome_arquivo = "#{Time.zone.now.to_i}#{usuario.id}"
      ArquivoRecadastramentoJob.perform_async(usuario, @nome_arquivo)

      render json: { success: true, nome_arquivo: @nome_arquivo }, status: :ok
    else
      render json: { success: false, message: "Usuário #{usuario.nome} não possui dados para gerar o arquivo." }, status: :ok
    end
  end
end