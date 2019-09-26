class BairroAreasController < ApplicationController
  def index
    if params[:query]
      query = params[:query]
      @bairro_areas = BairroArea.com_dados.filtrar_campos(query)
    else
      @bairro_areas = BairroArea.com_dados.all
    end
  end
end