class RegioesDesenvolvimentoController < ApplicationController
  def index
    if params[:query]
      query = params[:query].deep_symbolize_keys
      @regioes_desenvolvimento = RegiaoDesenvolvimento.filter(query)
      
      unless params[:paginado] == "false"
        @total = @regioes_desenvolvimento.count
        @regioes_desenvolvimento = @regioes_desenvolvimento.page(params[:page]).per(params[:per] || 20)
      end
    else
      @regioes_desenvolvimento = RegiaoDesenvolvimento.all
    end
  end
end
