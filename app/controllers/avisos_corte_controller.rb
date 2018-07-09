class AvisosCorteController < ApplicationController

	def create
    @path = 'public/avisos_corte'
    @file_name = params[:nomeArquivo]

    @nome_empresa = params[:nomeEmpresa]
    @endereco_empresa = params[:enderecoEmpresa]
    @cep_empresa = params[:cepEmpresa]
    @cnpj_empresa = params[:cnpjEmpresa]
    @fone_fax_empresa = params[:foneFaxEmpresa]

    @avisos = montar_avisos(params[:avisos])
    
    @path = salvar(pdf)

    if not @path.nil?
      render json: { url: "http://#{request.host_with_port}/avisos_corte" }, status: 200
    else
      render json: { error: "Não foi possível gerar o documento." }, status: 422
    end
  end

  private

  def montar_avisos(array)
    avisos = Array.new

    array.each do |aviso|
      avisos << AvisoCorte.new(aviso)
    end

    return avisos
  end

  def salvar(pdf)
    Dir.mkdir(@path) unless File.exists?(@path)

    save_path = Rails.root.join(@path, @file_name)
    File.open(save_path, 'wb') do |file|
      file << pdf
    end
  end

  def pdf
    WickedPdf.new.pdf_from_string(
      render_to_string('avisos_corte/create.pdf.erb',
                       layout: 'layouts/aviso_corte.html.erb', 
                       margin: { top: 7, bottom: 7, left: 3, right: 3 })
    )
  end

end