class RelatorioPdf < Relatorio::Base
  attr_accessor :file_name, :path, :relatorio, :cabecalho, :dados, :grupos, :titulo, :alinhamentos, :resumo

  def initialize(options={})
    @file_name = options[:name] || "novo_relatorio.pdf"
    @path = "public/relatorios/"
    @titulo = options[:titulo] || TITULO_PADRAO

    carrega_dados(options)
  end

  def salvar
    Dir.mkdir(@path) unless File.exists?(@path)

    data = @dados

    resume = @resumo

    data.insert 0, @cabecalho

    print_time = DateTime.now.strftime("%d/%m/%Y - %H:%M")

    image_path = "public/logo_cosanpa_rel.jpg"
    header = [[{image: image_path, rowspan: 2, scale: 0.6}, TEXTO_HEADER], [@titulo]]

    alinhamentos = @alinhamentos

    Prawn::Document.generate(
      "#{@path}#{@file_name}",
      top_margin: 70
    ) do

      repeat :all do
        # header
        canvas do
          bounding_box([bounds.left, bounds.top], :width => bounds.width) do
            table header, cell_style: {borders: [], align: :center, size: 11}, position: :center
          end
        end

        # footer
        canvas do
          bounding_box [bounds.left, bounds.bottom + 50], :width  => bounds.width do
            cell :content => "Emitido em: #{print_time}",
                 :width => bounds.width,
                 :height => 50,
                 :align => :left,
                 :text_color => "000000",
                 :borders => [:top],
                 :border_width => 0,
                 :border_color => '000000',
                 :padding => 12
          end
        end
      end

      print_table(data, alinhamentos)

      move_down 20

      print_table(resume, alinhamentos) unless resume.nil?

      # page number
      string = "Página <page> de <total>"
      options = {
        :at => [bounds.right - 150, 0],
        :width => 150,
        :align => :right,
        :start_count_at => 1,
        :color => "000000"
      }
      number_pages string, options
    end

    "#{@path}#{@file_name}".gsub("public/", "")
  end

private

  def carrega_dados(options)
    return if options.nil?

    @cabecalho = options[:cabecalho].map{ |item| item[:description] }
    @alinhamentos = options[:cabecalho].map{ |item| item[:align] }
    @grupos = options[:grupos] if options[:grupos]

    @dados = dados_ordenados(options, true, true)
    @resumo = monta_resumo(options)
  end
end

class Prawn::Document
  def print_table(data, alinhamentos)
      table(
        data,
        cell_style: {size: 8, valign: :center, inline_format: true},
        position: :center,
        header: true
      ) do
        alinhamentos.each_with_index do |align, index|
          columns(index).style align: align.to_sym
        end

        cells.padding = [8, 14, 8, 14]
        cells.borders = []

        row(0).borders = [:bottom]
        row(0).border_width = 1

        columns(0..(data.first.size-2)).borders = [:bottom]
        columns((data.first.size-1)..(data.first.size-1)).borders = [:bottom]

        row(0).columns(0..(data.first.size-2)).borders = [:bottom]
        row(0).font_style = :bold
      end
  end
end