class LeituristasController < ApplicationController

  def index
    if params[:query].present?
      params[:query].delete(:page)
      params[:query].delete(:per_page)

      @leituristas = Leiturista.where(params_query)
    else
      @total       = Leiturista.count
      @leituristas = Leiturista.all
    end
  end

  private

  def params_query
    params.require(:query).permit :empr_id, :nome
  end
end
