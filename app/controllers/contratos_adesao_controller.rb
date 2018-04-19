class ContratosAdesaoController < ApplicationController

  def index
  end

  def create
    
    @nome_arquivo = params[:nomeRelatorio]
    @nome_cliente = params[:nomeCliente]
    @matricula = params[:matricula]
    @numero_contrato = params[:numeroContrato]
    @nome_cidade = params[:nomeCidade]
    @data_geracao = params[:dataGeracao]

    path = salvar(pdf)

    if not path.nil?
      render json: { url: "http://#{request.host_with_port}/contrato_adesao" }, status: 200
    else
      render json: { error: "Não foi possível gerar o contrato de adesão" }, status: 422
    end
  end

  private

  def pdf
    WickedPdf.new.pdf_from_string(
      render_to_string('contratos_adesao/create.pdf.erb',
                       layout: 'layouts/contrato_adesao.html.erb', 
                       margin: { top: 7, bottom: 7, left: 3, right: 3 })
    )
  end

  def salvar(pdf)
    path = 'public/contratos_adesao'
    Dir.mkdir(path) unless File.exists?(path)

    save_path = Rails.root.join(path, @nome_arquivo)
    File.open(save_path, 'wb') do |file|
      file << pdf
    end
  end

end