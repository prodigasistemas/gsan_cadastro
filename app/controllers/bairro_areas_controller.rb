class BairroAreasController < ApplicationController
  def index
    if params[:query]
      query = params[:query].deep_symbolize_keys
      @bairro_areas = BairroArea.filter(query)
    else
      @bairro_areas = BairroArea.all
    end
  end
end