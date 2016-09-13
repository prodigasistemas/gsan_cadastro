class EmpresasController < ApplicationController
  def index
    if params[:query].present?
      params[:query].delete(:page)
      params[:query].delete(:per_page)
      
      @empresas = Empresa.where(params_query)
    else
      @total    = Empresa.count
      @empresas = Empresa.all
    end
  end

  def usuario
    usuario = Usuario.find params[:usuario_id]
    @empresas = usuario.empresas
    render json: { entidades: @empresas.map(&:atributos) }
  end

  private

  def params_query
    params.require(:query).permit :empr_id, :nome
  end
end