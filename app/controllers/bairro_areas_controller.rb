class BairroAreasController < ApplicationController
  def index
    if params[:query]
      query = params[:query].deep_symbolize_keys
      @bairro_areas = BairroArea.com_dados.filter(query)
    else
      @bairro_areas = BairroArea.com_dados.all
    end
  end
end