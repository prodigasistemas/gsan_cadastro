class RelatorioService
  attr_accessor :relatorio

  FORMATOS = [
    "pdf",
    "xls"
  ]

  def initialize(options = {})
    return if options[:cabecalho].nil? or options[:dados].nil?

    if options[:formato] and FORMATOS.include? options[:formato].downcase
      klass = Kernel.const_get "Relatorio#{options[:formato].capitalize}"
      @relatorio = klass.new options
    else
      @relatorio = RelatorioXls.new options
    end
  end

  def gerar
    return if @relatorio.nil?
    @relatorio.salvar
  end
end
