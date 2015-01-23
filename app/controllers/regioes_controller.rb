class RegioesController < ApplicationController
  def index
    if params[:query].present?
      query = params[:query].deep_symbolize_keys
      @regioes = Regiao.filter(query)
      @total = @regioes.count
      @regioes = @regioes.page(params[:page]).per(20)
    else
      @regioes = Regiao.all
    end
  end
end