class FiltrosController < ApplicationController
  before_action :define_tipo

  [NameError, LoadError].each do |exception|
    rescue_from exception do
      render json: { error: "Tipo não existente" }, status: :bad_request
    end
  end

  rescue_from NoMethodError do
    render json: { error: "Não é possível filtrar #{params[:tipo]}".strip }, status: :bad_request
  end

  rescue_from ActionController::ParameterMissing do
    render json: { error: "Atributos de busca inválidos" }, status: :bad_request
  end

  def index
    @retorno = @tipo.filtrar_dados(filtros[:termo], filtros[:incluir])
    render json: { entidades: @retorno.map(&:atributos) }
  end

  protected

  def define_tipo
    @tipo = params[:tipo].downcase.classify.constantize
  end

  def filtros
    params.require(:filtros).permit([
      :termo,
      incluir: []
    ])
  end
end
