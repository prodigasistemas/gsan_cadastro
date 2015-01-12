class TipoLogradourosController < ApplicationController
  def index
    @tipo_logradouros = TipoLogradouro.all
  end
end
