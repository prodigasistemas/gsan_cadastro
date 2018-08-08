class AtualizacaoCadastraisController < ApplicationController

  def index
    @atualizacao_cadastrais = []
    @per = params[:per_page] || 20
    @page = params[:page] || 0

    if params[:query].present?
      if params[:query][:codigo_imovel].present?
        params[:query][:page].delete
        params[:query][:per_page].delete
        @atualizacao_cadastrais = AtualizacaoCadastral.where(tatc_cdimovel: atualizacao_cadastral_params[:codigo_imovel])
      else
        @atualizacao_cadastrais = AtualizacaoCadastral.buscar_atualizacoes_para_recadastramento params[:query]
      end
    end

    unless @atualizacao_cadastrais.nil? and @atualizacao_cadastrais.empty?
      if params[:query][:codigo_imovel].present?
        render json: { entidades: @atualizacao_cadastrais.map(&:atributos), total: @total, page: @page, per_page: @per }, status: :ok
      else
        render json: { entidades: @atualizacao_cadastrais, total: @total, page: @page, per_page: @per }, status: :ok
      end
    else
      render json: { entidades: [], total: @total }, status: :ok
    end
  end

  def update
    @atualizacao_cadastrais = AtualizacaoCadastral.buscar_atualizacoes_para_recadastramento params[:query]
    if ImovelAtualizacaoCadastral.atualizar_lote @atualizacao_cadastrais.map {|h| h["codigo_imovel"] }, params[:query][:situacao_cadastral_id]
      render json: {}, status: :ok
    else
      render json: {}, status: :internal_server_error
    end
  end

  private

  def atualizacao_cadastral_params
    params.require(:query).permit(:codigo_imovel, :situacao_cadastral_id)
  end
end
