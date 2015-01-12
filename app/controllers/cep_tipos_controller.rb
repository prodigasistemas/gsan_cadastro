class CepTiposController < ApplicationController
  def index
    @cep_tipos = CepTipo.ativo
  end
end
