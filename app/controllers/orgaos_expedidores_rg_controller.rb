class OrgaosExpedidoresRgController < ApplicationController
  def index
    @orgaos = OrgaoExpedidorRg.all
  end

  def index
    if params[:query]
      query = params[:query]
      @orgaos_expedidores_rg = OrgaoExpedidorRg.order(:descricao).filter_data(query)

      unless params[:paginado] == "false"
        @total = @orgaos_expedidores_rg.count
        @orgaos_expedidores_rg = @orgaos_expedidores_rg.page(params[:page]).per(params[:per] || 20)
      end
    else
      @orgaos_expedidores_rg = OrgaoExpedidorRg.order(:descricao).all
    end
  end

  def show
    @orgao_expedidor_rg = OrgaoExpedidorRg.find(params[:id])
  end

  def create
    @orgao_expedidor_rg = OrgaoExpedidorRg.new(orgao_expedidor_rg_params)

    if @orgao_expedidor_rg.save
      render :show
    else
      render json: { errors: @orgao_expedidor_rg.errors.full_messages }, status: 422
    end
  end

  def update
    @orgao_expedidor_rg = OrgaoExpedidorRg.find(params[:id])

    if @orgao_expedidor_rg.update orgao_expedidor_rg_params
      render json: {}
    else
      render json: { errors: @orgao_expedidor_rg.errors.full_messages }, status: 422
    end
  end

  private

  def orgao_expedidor_rg_params
    params.require(:orgao_expedidor_rg).permit  :descricao, :descricao_abreviada, :ativo
  end
end
