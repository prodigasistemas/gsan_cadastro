class ContasSegundaViaController < ApplicationController

  def create
    @path = 'public/contas_segunda_via'
    @file_name = params[:nomeArquivo]
    @contas = montar_contas(params[:contas])
    @path = salvar(pdf)

    if not @path.nil?
      render json: { url: "http://#{request.host_with_port}/contas_segunda_via" }, status: 200
    else
      render json: { error: "Não foi possível gerar a Segunda Via de Conta" }, status: 422
    end
  end

  private

  def montar_contas(array)
    contas = Array.new

    array.each do |conta|
      contas << ContaSegundaVia.new(conta)
    end

    return contas
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
      render_to_string('contas_segunda_via/create.pdf.erb',
                       layout: 'layouts/conta_segunda_via.html.erb', 
                       margin: { top: 7, bottom: 7, left: 3, right: 3 })
    )
  end

end