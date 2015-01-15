class TituloLogradourosController < ApplicationController
  def index
    @titulo_logradouros = TituloLogradouro.all
  end
end