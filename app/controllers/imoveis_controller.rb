class ImoveisController < ApplicationController
  def index
    @imoveis = Imovel.com_dados.buscar(params[:query]) if params[:query].present?
    @imoveis ||= Imovel.buscar

    if @imoveis.any?
      meta = {
        total: @imoveis.total_count,
        pagina: @imoveis.current_page,
        por_pagina: params[:query][:per_page]
      }

      render json: { meta: meta, entidades: @imoveis.map{|i| i.atributos([:endereco_completo]) }}, status: :ok
    else
      render json: { entidades: [] }, status: :ok
    end
  end

  def show
    @imovel = Imovel.com_escopo([:logradouro]).find(params[:id])

    if @imovel
      render json: { entidade: @imovel.atributos([:endereco_completo, :dados_cadastrais]) }, status: :ok
    else
      render json: {}, status: :not_found
    end
  end

end