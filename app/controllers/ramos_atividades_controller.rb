class RamosAtividadesController < ApplicationController
  def index
    @ramos = RamoAtividade.all
  end
end
