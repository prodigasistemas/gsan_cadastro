class ImoveisController < ApplicationController
  before_action :busca_imovel, only: :show

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
    if @imovel
      render json: { entidade: @imovel.atributos(inclusoes) }, status: :ok
    else
      render json: {}, status: :not_found
    end
  end

  protected 

  def busca_imovel
    @imovel = Imovel.com_escopo([:logradouro]).find(params[:id]) 
  end

  def inclusoes 
    [:dados_gerais, :endereco_completo]
  end
end