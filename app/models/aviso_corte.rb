class AvisoCorte

  require 'barby'
  require 'barby/barcode/code_25_interleaved'
  require 'barby/outputter/png_outputter'
  require 'chunky_png'

  attr_accessor :imovel, :cliente, :inscricao, :rota_codigo, :rota_sequencial,
  							:documento_cobranca, :valor_total,
  							:endereco, :endereco_correspondencia, :complemento_correspondencia, :cidade_estado_correspondencia, :bairro_correspondencia, :cep_correspondencia,
  							:codigo_barras, :codigo_barras_formatado,
  							:contas

  def initialize(options = {})
    return if options.nil?

    @imovel 													= options[:imovel]
    @cliente 													= options[:cliente]
    @inscricao 												= options[:inscricao]
    
    @mes_ano 													= options[:mesAno]
    @vencimento 											= options[:dataVencimento]
    
    @valor 														= options[:valor]
    
    @rota_codigo 											= options[:codigoRota]
    @rota_sequencial 									= options[:sequencialRota]
    
    @documento_cobranca 							= options[:idDocumentoCobranca]
    @valor_total 											= options[:valorTotal]
  	
  	@endereco 												= options[:endereco]
  	
  	@endereco_correspondencia 				= options[:enderecoCorrespondencia]
  	@complemento_correspondencia 			= options[:complementoCorrespondencia]
  	@cidade_estado_correspondencia 		= options[:cidadeEstadoCorrespondencia]
  	@bairro_correspondencia 					= options[:bairroCorrespondencia]
  	@cep_correspondencia 							= options[:cepCorrespondencia]
  	
  	@codigo_barras 										= gerar_codigo_barras(options[:codigoBarras])
  	@codigo_barras_formatado 					= options[:codigoBarrasFormatado]

  	montar_contas(options[:contas])
  end

	private

  def gerar_codigo_barras(code)
    barcode = Barby::Code25Interleaved.new(code)
    barcode.to_image(height: 50, margin: 5).to_data_url
  end

  def montar_contas(array)
    @contas = Array.new
    array.each do |conta|
      @contas << AvisoCorteConta.new(conta)
    end

    # if @contas.size > 18
    # 	@contas_2 = @contas.slice(18, contas.size)
    # end
  end

end