class SubcategoriasController < ApplicationController
  def index
    @subcategorias = []
    if params[:query].present?
      params[:query].delete :page
      params[:query].delete :per_page
      imovel_subcategorias = ImovelSubcategoria.buscar params.require(:query).permit!
      imovel_subcategorias.each do |is|
        subcategoria = is.subcategoria
        subcategoria.quantidade = is.qtd_economias
        @subcategorias << subcategoria
      end
    end

    if @subcategorias.any?
      meta = {
        total: @subcategorias.count
      }

      render json: { meta: meta, entidades: @subcategorias.map(&:atributos) }, status: :ok
    else
      render json: { entidades: [] }, status: :ok
    end
  end
end
