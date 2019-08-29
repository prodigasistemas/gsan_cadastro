class ClienteImoveisController < ApplicationController
  def index
    @cliente_imoveis = Imovel.por_cliente(params[:query]) if params[:query].present?
    @cliente_imoveis ||= Imovel.buscar

    if @cliente_imoveis.any?
      meta = {
        total: @cliente_imoveis.total_count,
        pagina: @cliente_imoveis.current_page,
        por_pagina: params[:query][:per_page]
      }

      render json: { meta: meta, entidades: @cliente_imoveis.map(&:atributos)}, status: :ok
    else
      render json: { entidades: [] }, status: :ok
    end
  end
end