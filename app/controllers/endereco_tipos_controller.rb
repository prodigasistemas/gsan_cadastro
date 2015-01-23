class EnderecoTiposController < ApplicationController
  def index
    @tipos = EnderecoTipo.all
  end
end
