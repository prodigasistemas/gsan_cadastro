class ContratosMedicaoController < ApplicationController
  def index
      @total = ContratoMedicao.count
      @contratos = ContratoMedicao.all
  end

  def show
    @contrato = ContratoMedicao.find(params[:id])
  end

  def create
    @contrato = ContratoMedicao.new(contrato_params)

    if @contrato.save
      render :show
    end
  end

  private 
  def contrato_params
    params.require(:contrato)
      .permit(:numero,
              :vigencia_inicial,
              :vigencia_final,
              :data_asinatura,
              :empresa_id)

  end
end
