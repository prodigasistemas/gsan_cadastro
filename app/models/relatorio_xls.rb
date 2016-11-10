class RelatorioXls < Relatorio::Base
  attr_accessor :file_name, :path, :relatorio, :planilha, :cabecalho, :dados

  LINHA_HEADER    = 0
  LINHA_TITULO    = 1
  LINHA_SUBTITULO = 3
  LINHA_CABECALHO = 4
  LINHA_INICIO_DADOS = 5

  def initialize(options={})
    Spreadsheet.client_encoding = 'UTF-8'
    @relatorio = Spreadsheet::Workbook.new
    @file_name = options[:name] || "novo_relatorio.xls"
    @path = "public/relatorios/"

    criar_planilha options[:nome_planilha] || "Sheet 1"
    carregar_dados options unless options[:cabecalho].nil? or options[:dados].nil?
    agrupa_celulas options[:grupos] if options[:grupos]

    @titulo = options[:titulo] || TITULO_PADRAO
    @subtitulo = options[:subtitulo] || ''
    monta_cabecalho options[:cabecalho]
  end

  def salvar
    Dir.mkdir(@path) unless File.exists?(@path)

    @relatorio.write "#{@path}#{@file_name}"
    "#{@path}#{@file_name}".gsub("public/", "")
  end

  private

  def carregar_dados infos
    @dados = dados_ordenados(infos) if infos[:grupos]
    @dados ||= monta_dados(infos)
    @dados.size.times { |row| @planilha.row(row + LINHA_INICIO_DADOS).replace @dados[row] }
  end

  def agrupa_celulas(grupos)
    return @dados if grupos.nil?

    @grupo_selecionado = []

    @dados.each_with_index do |dado, linha| 
      grupos.size.times do |coluna|
          configura_linha(dado, linha, coluna) if not @grupo_selecionado.include? dado[0..coluna].join
      end
    end
  end

  def configura_linha(dado, linha, coluna)
    dado_selecionado = dado[0..coluna].join

    rowspan = @dados.select do |d| 
      d.join.include? dado_selecionado and d[coluna] == dado[coluna]
    end.size
  
    @planilha.merge_cells(linha + LINHA_INICIO_DADOS, coluna, ((linha + (LINHA_INICIO_DADOS - 1)) + rowspan), coluna)

    format = Spreadsheet::Format.new vertical_align: :middle
    @planilha.row(linha + LINHA_INICIO_DADOS).default_format = format

    @grupo_selecionado << dado_selecionado
  end

  def criar_planilha titulo
    @planilha = @relatorio.create_worksheet name: titulo
  end

  def monta_cabecalho(cabecalho)
    @cabecalho = cabecalho.map{ |item| item[:description] }

    configura_header(@titulo, LINHA_TITULO, :formatacao_titulo)
    configura_header(@subtitulo, LINHA_SUBTITULO, :formatacao_subtitulo)
    configura_header(TEXTO_HEADER, LINHA_HEADER, :formatacao_header)

    @planilha.row(LINHA_CABECALHO).concat @cabecalho
    @planilha.row(LINHA_CABECALHO).default_format = formatacao_cabecalho
  end

  def configura_header(texto, linha_inicio, formatacao)
    @planilha.merge_cells linha_inicio, 0, linha_inicio, @cabecalho.size - 1
    @planilha.row(linha_inicio).push texto
    @planilha.row(linha_inicio).default_format = self.send(formatacao)
  end

  def formatacao_header
    Spreadsheet::Format.new weight: :bold, align: :center, size: 12
  end

  def formatacao_titulo
    Spreadsheet::Format.new weight: :bold, align: :center, size: 12
  end

  def formatacao_subtitulo
    Spreadsheet::Format.new align: :left, size: 10
  end

  def formatacao_cabecalho
    Spreadsheet::Format.new weight: :bold, size: 11
  end
end
