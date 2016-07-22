class AssociacoesController < ApplicationController
  BLACKLIST = %w(destroy save delete update delete_all update_all)

  before_action :define_objeto, :verifica_params

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

    if @retorno.respond_to? :size
      render json: { entidades: @retorno.map(&:atributos) }
    else
      render json: { entidade: @retorno.try(:atributos) }
    end
  end

  protected

  def define_objeto
    @objeto = params[:objeto].downcase.classify.constantize.find(params[:objeto_id])
  end

  def verifica_params
    if BLACKLIST.include?(params[:associacao])
      raise RuntimeError
    end
  end
end
