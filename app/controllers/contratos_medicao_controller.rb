class ContratosMedicaoController < ApplicationController
  def index
      @total = ContratoMedicao.count
      @contratos = ContratoMedicao.all
  end
end
