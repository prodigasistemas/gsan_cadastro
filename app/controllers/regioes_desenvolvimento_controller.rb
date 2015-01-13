class RegioesDesenvolvimentoController < ApplicationController
  def index
    @regioes_desenvolvimento = RegiaoDesenvolvimento.all
  end
end
