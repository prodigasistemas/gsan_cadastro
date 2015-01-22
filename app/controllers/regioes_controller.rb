class RegioesController < ApplicationController
  def index
    @regioes = Regiao.ativos
  end
end