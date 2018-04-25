class ContasSegundaViaController < ApplicationController

  def create
    @conta = ContaSegundaVia.new(params)
    path = @conta.salvar(pdf)

    if not path.nil?
      render json: { url: "http://#{request.host_with_port}/contas_segunda_via" }, status: 200
    else
      render json: { error: "Não foi possível gerar a Segunda Via de Conta" }, status: 422
    end
  end

  private

  def pdf
    WickedPdf.new.pdf_from_string(
      render_to_string('contas_segunda_via/create.pdf.erb',
                       layout: 'layouts/conta_segunda_via.html.erb', 
                       margin: { top: 7, bottom: 7, left: 3, right: 3 })
    )
  end

end