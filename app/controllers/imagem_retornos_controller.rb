class ImagemRetornosController < ApplicationController

  def index
    @imovel_imagens = ImagemRetorno.por_imovel params_imovel_imagem[:imovel_id]
    unless @imovel_imagens.empty?
      render json: { entidades: @imovel_imagens.map(&:atributos) }, status: :ok
    else
      render json: {}, status: :not_found
    end
  end

  private
    def params_imovel_imagem
      params.require(:query).permit(:imovel_id, :page, :per_page)
    end
end
