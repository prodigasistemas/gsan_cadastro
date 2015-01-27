class BairroAreasController < ApplicationController
  def index
    if params[:query]
      query = params[:query].deep_symbolize_keys
      @bairro_areas = BairroArea.join.filter(query)
    else
      @bairro_areas = BairroArea.join.all
    end
  end
end