class BairrosController < ApplicationController
  def index
    if params[:query]
      query = params[:query].deep_symbolize_keys
      query[:nome] = nil

      @bairros = Bairro.includes(:municipio).where(query.reject! { |k, v| v.blank? })
      @bairros = @bairros.where("UPPER(bair_nmbairro) LIKE ?", "%#{params[:query][:nome].upcase}%") if params[:query][:nome]

      @total = @bairros.count
      @bairros = @bairros.page(params[:page]).per(20)
    else
      @bairros = Bairro.includes(:municipio).all
    end
  end
end
