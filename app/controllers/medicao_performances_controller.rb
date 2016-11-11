class MedicaoPerformancesController < ApplicationController
  def index
    @medicoes = MedicaoPerformance.filtrar params

    render json: { entidades: @medicoes.map(&:atributos) }, status: :ok
  end
end