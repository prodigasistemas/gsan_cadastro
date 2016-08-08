class AssociacoesController < ApplicationController
  BLACKLIST = %w(destroy save delete update delete_all update_all)

  before_action :define_objeto, :verifica_params, :verifica_paginacao

  rescue_from NameError do
    render json: { error: "Não existe model #{params[:objeto]}".strip }, status: :bad_request
  end

  rescue_from ActiveRecord::RecordNotFound do
    render json: { error: "Objeto não encontrado" }, status: :bad_request
  end

  rescue_from NoMethodError do
    render json: { error: "Não existe associacao #{params[:associacao]} para #{params[:objeto]}".strip }, status: :bad_request
  end

  rescue_from RuntimeError do
    render json: { error: "Parametro inválido" }, status: :bad_request
  end

  def index
    @retorno = @objeto.send(params[:associacao])
    @retorno = @retorno.com_escopo if @retorno.respond_to? :com_escopo

    render json: resposta, status: :ok
  end

  private

  def define_objeto
    @objeto = params[:objeto].downcase.classify.constantize.find(params[:objeto_id])
  end

  def verifica_params
    raise RuntimeError if BLACKLIST.include?(params[:associacao])
  end

  def verifica_paginacao
    @pagina     = params[:page]
    @por_pagina = params[:per_page].present? ? params[:per_page] : 50
  end

  def resposta
    if @retorno.respond_to? :size
      meta = {}

      if @pagina
        @retorno = @retorno.page(@pagina).per(@por_pagina)

        meta.merge!({
          total: @retorno.total_count,
          pagina: @retorno.current_page,
          por_pagina: @por_pagina
        })
      end

      { meta: meta, entidades: @retorno.map(&:atributos) }
    else
      { entidade: @retorno.try(:atributos) }
    end
  end
end
