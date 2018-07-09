class ColunasAtualizacoesCadastralController < ApplicationController

  def index
    @colunas_atualizacoes_cadastral = []
    @per = params[:per] || 20
    @page = params[:page] || 0

    if params[:query]
      query = params[:query].deep_symbolize_keys
      @colunas_atualizacoes_cadastral = ColunaAtualizacaoCadastral.order(:atualizacao_cadastral_id).where(query)

      unless params[:paginado] == "false"
        @total = @colunas_atualizacoes_cadastral.count
        @colunas_atualizacoes_cadastral = @colunas_atualizacoes_cadastral.page(@page).per(@per)
      end
    else
      @total = ColunaAtualizacaoCadastral.count
      @colunas_atualizacoes_cadastral = ColunaAtualizacaoCadastral.joins(:atualizacao_cadastral).order(:atualizacao_cadastral_id).page(@page).per(@per)
    end

    if @colunas_atualizacoes_cadastral.any?
      render json: { entidades: @colunas_atualizacoes_cadastral.map(&:atributos), total: @total, page: @page, per_page: @per }, status: :ok
    else
      render json: { entidades: [], total: @total }, status: :ok
    end
  end

end
