class CepTiposController < ApplicationController
  def index
    @cep_tipos = CepTipo.ativo.order(descricao: :asc)
  end
end
