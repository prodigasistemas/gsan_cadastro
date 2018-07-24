module CodigoBarras

  require 'barby'
  require 'barby/barcode/code_25_interleaved'
  require 'barby/outputter/png_outputter'
  require 'chunky_png'

  def gerar_codigo_barras(code)
    barcode = Barby::Code25Interleaved.new(code)
    barcode.to_image(height: 50, margin: 5).to_data_url
  end

end