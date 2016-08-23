class ImoveisController < ApplicationController
  def index
    @imoveis = Imovel.com_dados.buscar(params[:query]) if params[:query].present?
    @imoveis ||= Imovel.all

    if @imoveis.any?
      meta = {
        total: @imoveis.total_count,
        pagina: @imoveis.current_page,
        por_pagina: params[:query][:per_page]
      }

      render json: { meta: meta, entidades: @imoveis.map(&:atributos) }, status: :ok
    else
      render json: { entidades: [] }, status: :ok
    end
  end
end