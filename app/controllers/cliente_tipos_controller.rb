class ClienteTiposController < ApplicationController
  def index
    @cliente_tipos = ClienteTipo.order(:descricao).all
  end
end
