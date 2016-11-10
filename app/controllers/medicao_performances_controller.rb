class MedicaoPerformancesController < ApplicationController
  def index
    @medicoes = MedicaoPerformance.filtrar params

    render json: { entidades: @medicoes.map(&:atributos) }, status: :ok
  end

  def relatorio
    medicoes = MedicaoPerformance.filtrar params

    if medicoes.present?

      gerador = nil

      if params[:tipo] == 'analitico'
        gerador = MedicaoPerformancesRelatorioAnalitico.new(medicoes, params)
      else
        gerador = MedicaoPerformancesRelatorioSintetico.new(medicoes, params)
      end
      path = gerador.gerar
      render json: {success: true, url: "http://#{request.host_with_port}/#{path}"}, status: 200
    else
      render json: {success: false, error: "Não foram encontradas informações para a geração do relatório"}, status: 200
    end
  end
end