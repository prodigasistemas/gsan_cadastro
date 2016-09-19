class ArquivoHidrometroInstalacaoHistoricosController < ApplicationController
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
    data_inicial = params[:data_inicial].to_date if params[:data_inicial].present?
    data_final  = params[:data_final].to_date if params[:data_final].present?
    usuario_id = params[:usuario_id]

    usuario = Usuario.find usuario_id

    @nome_arquivo = "#{Time.zone.now.to_i}#{usuario.id}"

    hidrometro_historicos = HidrometroInstalacaoHistorico.filtrar_por(params)
    hidrometro_historicos ||= []

    if hidrometro_historicos.any?

      historico = HistoricoArquivoRetorno.create(
                                          usuario_id: usuario_id,
                                          situacao: 'pendente'
                                        )

      ArquivoHidrometroInstalacaoHistoricoJob.perform_async(hidrometro_historicos, @nome_arquivo, historico)


      render json: { success: true, nome_arquivo: @nome_arquivo, nome: usuario.nome, historico: historico.atributos }, status: :ok
    else
      render json: { success: false, message: "Não possui dados para gerar o arquivo." }, status: :ok
    end
  end
end