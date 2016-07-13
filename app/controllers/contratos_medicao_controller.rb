class ContratosMedicaoController < ApplicationController
  def index
      @total = ContratoMedicao.count
      @contratos = ContratoMedicao.all
  end

  def show
    @contrato = ContratoMedicao.find(params[:id])
  end
end
