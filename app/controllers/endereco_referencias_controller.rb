class EnderecoReferenciasController < ApplicationController
  def index
    @referencias = EnderecoReferencia.all
  end
end
