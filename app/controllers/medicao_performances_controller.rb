class MedicaoPerformancesController < ApplicationController
  def index
    @medicoes = MedicaoPerformance.filtrar params

    render json: { entidades: @medicoes.map(&:atributos) }, status: :ok
  end

  def relatorio
    medicoes = MedicaoPerformance.filtrar params

    gerador = MedicaoPerformancesRelatorio.new(medicoes, params[:formato])

    path = gerador.gerar

    if not path.nil?
      render json: {success: true, url: "http://#{request.host_with_port}/#{path}"}, status: 200
    else
      render json: {success: false, error: "Não foram encontradas informações para a geração do relatório"}, status: 422
    end
  end
end