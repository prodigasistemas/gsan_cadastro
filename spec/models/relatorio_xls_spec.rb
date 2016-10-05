require 'rails_helper'

describe RelatorioXls, type: :model do
  let(:relatorio) {
    {
      cabecalho: [
        { name: "municipio",      description: "Município",         align: "left",    type: "string" },
        { name: "localidade",     description: "Localidade",        align: "left",    type: "string" },
        { name: "descricao",      description: "Produto",           align: "left",    type: "string" },
        { name: "unidadeMedida",  description: "Unidade de Medida", align: "center",  type: "string" },
        { name: "valorBruto",     description: "Valor Bruto",       align: "right",   type: "money" },
        { name: "valorLiquido",   description: "Valor Líquido",     align: "right",   type: "money" }
      ],
      dados: [
        { municipio: "Belem",     localidade: "Marco",    descricao: "Cal",   unidadeMedida: "5 Kg",  valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belem",     localidade: "Marco",    descricao: "Fluor", unidadeMedida: "15 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belem",     localidade: "Marco",    descricao: "Poli",  unidadeMedida: "15 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belem",     localidade: "Marco",    descricao: "Sódio", unidadeMedida: "5 Kg",  valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belem",     localidade: "Pedreira", descricao: "Fluor", unidadeMedida: "15 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Santarém",  localidade: "Alter",    descricao: "Cal",   unidadeMedida: "20 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Santarém",  localidade: "Alter",    descricao: "Cloro", unidadeMedida: "10 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Santarém",  localidade: "Pedreira", descricao: "Cal",   unidadeMedida: "15 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Santarém",  localidade: "Pedreira", descricao: "Fluor", unidadeMedida: "20 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
      ],
      grupos: [ { name: "municipio" }, { name: "localidade" } ],
      totalizadores: [ { name: "valorBruto" }, { name: "valorLiquido" } ]
    }
  }

  let(:dados_ordenados) {
    [
      ["Total",    "-",         "-",      "-",      "900,00", "450,00"],
      ["Belem",    "-",         "-",      "-",      "500,00", "250,00"],
      ["Belem",    "Marco",     "-",      "-",      "400,00", "200,00"],
      ["Belem",    "Marco",     "Cal",    "5 Kg",   "100,00", "50,00"],
      ["Belem",    "Marco",     "Fluor",  "15 Kg",  "100,00", "50,00"],
      ["Belem",    "Marco",     "Poli",   "15 Kg",  "100,00", "50,00"],
      ["Belem",    "Marco",     "Sódio",  "5 Kg",   "100,00", "50,00"],
      ["Belem",    "Pedreira",  "Fluor",  "15 Kg",  "100,00", "50,00"],
      ["Santarém", "-",         "-",      "-",      "400,00", "200,00"],
      ["Santarém", "Alter",     "-",      "-",      "200,00", "100,00"],
      ["Santarém", "Alter",     "Cal",    "20 Kg",  "100,00", "50,00"],
      ["Santarém", "Alter",     "Cloro",  "10 Kg",  "100,00", "50,00"],
      ["Santarém", "Pedreira",  "-",      "-",      "200,00", "100,00"],
      ["Santarém", "Pedreira",  "Cal",    "15 Kg",  "100,00", "50,00"],
      ["Santarém", "Pedreira",  "Fluor",  "20 Kg",  "100,00", "50,00"]
    ]
  }

  subject { RelatorioXls.new relatorio}

  context "#initialize" do
    it "padrão" do
      expect(subject.file_name).to eq "novo_relatorio.xls"
    end

    it "com nome" do
      relatorio[:name] = "relatorio.xls"
      subject = RelatorioXls.new relatorio
      expect(subject.file_name).to eq "relatorio.xls"
    end
  end

  it "#criar_planilha" do
    relatorio[:nome_planilha] = "Sheet 1"
    subject = RelatorioXls.new relatorio
    expect(subject.planilha.name).to eq "Sheet 1"
  end

  it "#salvar" do
    path = subject.salvar
    spreadsheet = Spreadsheet.open "public/#{path}"

    expect(spreadsheet).not_to be_nil
  end

  it "agrupamento dos dados" do
    subject = RelatorioXls.new relatorio
    expect(subject.cabecalho).to eq ["Município", "Localidade", "Produto", "Unidade de Medida", "Valor Bruto", "Valor Líquido"]
    expect(subject.dados).to eq dados_ordenados
  end
end
