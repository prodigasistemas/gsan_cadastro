class VisitasController < ApplicationController
  def index
    if params[:query].present?
      params[:query].delete(:page)
      params[:query].delete(:per_page)
      @visitas = Visita.where(params_query)
    else
      @total    = Visita.count
      @visitas = Visita.all
    end
  end


  private

    def params_query
      params.require(:query).permit :icac_id
    end
end
