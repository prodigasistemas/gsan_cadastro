class MunicipiosController < ApplicationController
  def index
    @municipios = Municipio.all
  end
end
