class CadastroOcorrenciasController < ApplicationController

  def index
    if params[:query].present?
      params[:query].delete(:page)
      params[:query].delete(:per_page)

      @cadastro_ocorrencias = CadastroOcorrencia.where(params_query).order(:descricao)
    else
      @total                = CadastroOcorrencia.count
      @cadastro_ocorrencias = CadastroOcorrencia.all.order(:descricao)
    end
  end

  private

  def params_query
    params.require(:query).permit :cocr_id, :cocr_dscadastroocorrencia
  end
end
