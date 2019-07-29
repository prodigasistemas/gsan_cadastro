class BairroAreasController < ApplicationController
  def index
    if params[:query]
      query = params[:query]
      @bairro_areas = BairroArea.com_dados.filter_data(query)
    else
      @bairro_areas = BairroArea.com_dados.all
    end
  end
end