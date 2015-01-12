class BairrosController < ApplicationController
  def index
    @bairros = Bairro.pesquisar params[:query].permit!
  end
end
