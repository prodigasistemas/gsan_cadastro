class AtualizacaoCadastraisController < ApplicationController

  def index
    @atualizacao_cadastrais = []
    @per = params[:per_page] || 20
    @page = params[:page] || 0

    if params[:query]
      @atualizacao_cadastrais = AtualizacaoCadastral.buscar_atualizacoes_para_recadastramento params[:query]
    end

    if @atualizacao_cadastrais.any?
      render json: { entidades: @atualizacao_cadastrais, total: @total, page: @page, per_page: @per }, status: :ok
    else
      render json: { entidades: [], total: @total }, status: :ok
    end
  end

end
