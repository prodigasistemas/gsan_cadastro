class ClienteAtualizacaoCadastraisController < ApplicationController
  def index
    params[:query].delete :page
    params[:query].delete :per_page
    @cliente_atualizacacao_cadastrais = ClienteAtualizacaoCadastral.buscar params.require(:query).permit!
    if @cliente_atualizacacao_cadastrais.any?
      render json: { entidades: @cliente_atualizacacao_cadastrais.map(&:atributos) }, status: :ok
    else
      render json: { entidades: [] }, status: :not_found
    end
  end

  def show
    @cliente_atualizacacao_cadastral = ClienteAtualizacaoCadastral.find_by_id params[:id]
    if @cliente_atualizacacao_cadastral
      render json: { entidade: @cliente_atualizacacao_cadastral.atributos }, status: :ok
    else
      render json: { entidade: [] }, status: :not_found
    end
  end
end
