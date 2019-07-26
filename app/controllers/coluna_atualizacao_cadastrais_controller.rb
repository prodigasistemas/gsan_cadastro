class ColunaAtualizacaoCadastraisController < ApplicationController

  def index
    @coluna_atualizacao_cadastrais = []
    @per = params[:per_page] || 10000
    @page = params[:page] || 0
    params[:query].delete :per_page
    params[:query].delete :page

    if params[:query]
      query = params[:query]
      @coluna_atualizacao_cadastrais = ColunaAtualizacaoCadastral.com_relacionamentos.order(:atualizacao_cadastral_id, :id).where(query)

      unless params[:paginado] == "false"
        @total = @coluna_atualizacao_cadastrais.count
        @coluna_atualizacao_cadastrais = @coluna_atualizacao_cadastrais.page(@page).per(@per).com_relacionamentos
      end
    else
      @total = ColunaAtualizacaoCadastral.count
      @coluna_atualizacao_cadastrais = ColunaAtualizacaoCadastral.com_relacionamentos.order(:atualizacao_cadastral_id, :id).page(@page).per(@per)
    end

    if @coluna_atualizacao_cadastrais.any?
      render json: { entidades: @coluna_atualizacao_cadastrais.map {|c| Recadastramento::ColunaDto.new(c) }, total: @total, page: @page, per_page: @per }, status: :ok
    else
      render json: { entidades: [], total: @total }, status: :ok
    end
  end

end
