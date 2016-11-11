class ArquivoMedicaoPerformanceRelatoriosController < ApplicationController
  def show
    nome_arquivo = params[:nome_arquivo]
    caminho ="#{Rails.root}/public/relatorios/#{nome_arquivo}"

    if nome_arquivo.include?("xls")
      send_file caminho, :type=>"application/vnd.ms-excel", :x_sendfile=>true
    else
      send_file caminho, :type=>"application/pdf", :x_sendfile=>true
    end
  end

  def verify
    nome = params[:nome_arquivo]
    caminho ="#{Rails.root}/public/relatorios/#{nome}"

    if File.exists?(caminho)
      render json: { success: true }, status: :ok
    else
      render json: { success: false }, status: :ok
    end
  end

  def create
    medicoes = MedicaoPerformance.filtrar params

    contrato_medicao = ContratoMedicao.find(params[:contrato_medicao_id])
    empresa = contrato_medicao.empresa
    usuario = Usuario.find params[:usuario_id]

    if medicoes.present?
      if params[:tipo] == 'analitico'
        @nome_arquivo = "#{HistoricoArquivoRetorno::TIPO_ARQUIVO[:medicao_performance_analitico]}_#{Time.zone.now.to_i}#{empresa.id}.#{params[:formato]}"
        historico = HistoricoArquivoRetorno.create(
                                          usuario: usuario,
                                          situacao: HistoricoArquivoRetorno::SITUACAO[:pendente],
                                          tipo_arquivo: HistoricoArquivoRetorno::TIPO_ARQUIVO[:medicao_performance_analitico]
                                        )
        params[:nome_arquivo] = @nome_arquivo
        @gerador = MedicaoPerformancesRelatorioAnalitico.new(medicoes, params)
      else
        @nome_arquivo = "#{HistoricoArquivoRetorno::TIPO_ARQUIVO[:medicao_performance_sintetico]}_#{Time.zone.now.to_i}#{empresa.id}.#{params[:formato]}"
        historico = HistoricoArquivoRetorno.create(
                                          usuario: usuario,
                                          situacao: HistoricoArquivoRetorno::SITUACAO[:pendente],
                                          tipo_arquivo: HistoricoArquivoRetorno::TIPO_ARQUIVO[:medicao_performance_sintetico]
                                        )
        params[:nome_arquivo] = @nome_arquivo
        @gerador = MedicaoPerformancesRelatorioSintetico.new(medicoes, params)
      end

      ArquivoMedicaoPerformanceRelatorioJob.perform_async(@nome_arquivo, @gerador, historico)

      render json: { success: true, nome_arquivo: @nome_arquivo, responsavel: empresa.nome, historico: historico.atributos }, status: :ok
    else
      render json: { success: false, message: "O Contrato nº #{contrato_medicao.numero} não possui dados para gerar o arquivo." }, status: :ok
    end
  end
end