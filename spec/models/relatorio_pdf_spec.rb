require 'spec_helper'

describe RelatorioPdf, type: :model do
  let(:json) {
    {
      titulo: "Relatório de Teste",
      cabecalho: [
        { name: "municipio",      description: "Município",           align: "left",    type: "string" },
        { name: "localidade",     description: "Localidade",          align: "left",    type: "string" },
        { name: "descricao",      description: "Produto",             align: "left",    type: "string" },
        { name: "unidadeMedida",  description: "Unidade de Medida",   align: "center",  type: "string" },
        { name: "valorBruto",     description: "Valor Bruto",         align: "right",   type: "money" },
        { name: "valorLiquido",   description: "Valor Líquido",       align: "right",   type: "money" }
      ],
      grupos: [ { name: "municipio" }, { name: "localidade" } ],
      totalizadores: [ { name: "valorBruto" }, { name: "valorLiquido" } ],
      dados: [
        { municipio: "Belém",     localidade: "Batista Campos", descricao: "Poli",  unidadeMedida: "15 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belém",     localidade: "Benguí",         descricao: "Poli",  unidadeMedida: "15 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belém",     localidade: "Centro",         descricao: "Poli",  unidadeMedida: "15 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belém",     localidade: "Cidade Velha",   descricao: "Poli",  unidadeMedida: "15 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belém",     localidade: "Condor",         descricao: "Poli",  unidadeMedida: "15 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belém",     localidade: "Cremação",       descricao: "Poli",  unidadeMedida: "15 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belém",     localidade: "Guamá",          descricao: "Poli",  unidadeMedida: "15 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belém",     localidade: "Jurunas",        descricao: "Poli",  unidadeMedida: "15 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belém",     localidade: "Marco",          descricao: "Cal",   unidadeMedida: "5 Kg",  valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belém",     localidade: "Marco",          descricao: "Fluor", unidadeMedida: "15 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belém",     localidade: "Marco",          descricao: "Poli",  unidadeMedida: "15 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belém",     localidade: "Marco",          descricao: "Sódio", unidadeMedida: "5 Kg",  valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belém",     localidade: "Matinha",        descricao: "Poli",  unidadeMedida: "15 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belém",     localidade: "Nazaré",         descricao: "Poli",  unidadeMedida: "15 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belém",     localidade: "Pedreira",       descricao: "Fluor", unidadeMedida: "10 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belém",     localidade: "Pedreira",       descricao: "Fluor", unidadeMedida: "15 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belém",     localidade: "Pedreira",       descricao: "Poli",  unidadeMedida: "15 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belém",     localidade: "Pratinha",       descricao: "Poli",  unidadeMedida: "15 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belém",     localidade: "Reduto",         descricao: "Poli",  unidadeMedida: "15 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belém",     localidade: "São Brás",       descricao: "Poli",  unidadeMedida: "15 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belém",     localidade: "Tapanã",         descricao: "Poli",  unidadeMedida: "15 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belém",     localidade: "Telégrafo",      descricao: "Poli",  unidadeMedida: "15 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belém",     localidade: "Tenoné",         descricao: "Poli",  unidadeMedida: "15 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Belém",     localidade: "Umarizal",       descricao: "Poli",  unidadeMedida: "15 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Santarém",  localidade: "Alter",          descricao: "Cal",   unidadeMedida: "20 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Santarém",  localidade: "Alter",          descricao: "Cloro", unidadeMedida: "10 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Santarém",  localidade: "Alter",          descricao: "Poli",  unidadeMedida: "25 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Santarém",  localidade: "Pedreira",       descricao: "Fluor", unidadeMedida: "25 Kg", valorBruto: "100,00",  valorLiquido: "50,00" },
        { municipio: "Santarém",  localidade: "Pedreira",       descricao: "Sódio", unidadeMedida: "20 Kg", valorBruto: "100,00",  valorLiquido: "50,00" }
      ]
    }
  }

  subject { RelatorioPdf.new json }

  context "novo relatorio" do
    it "sem nome no arquivo" do
      expect(subject.file_name).to eq "novo_relatorio.pdf"
    end

    it "#carregar_dados" do
      expect(subject.cabecalho).to eq ["Município", "Localidade", "Produto", "Unidade de Medida", "Valor Bruto", "Valor Líquido"]
    end

    it "#configura_grupos" do
      expect(subject.dados).to eq [
                                    ["<b>Total</b>", "", "", "", "<b>2.900,00</b>", "<b>1.450,00</b>"],
                                    ["<b>Belém</b>", "", "", "", "<b>2.400,00</b>", "<b>1.200,00</b>"],
                                    ["", "Batista Campos", "Poli", "15 Kg", "100,00", "50,00"],
                                    ["", "Benguí", "Poli", "15 Kg", "100,00", "50,00"],
                                    ["", "Centro", "Poli", "15 Kg", "100,00", "50,00"],
                                    ["", "Cidade Velha", "Poli", "15 Kg", "100,00", "50,00"],
                                    ["", "Condor", "Poli", "15 Kg", "100,00", "50,00"],
                                    ["", "Cremação", "Poli", "15 Kg", "100,00", "50,00"],
                                    ["", "Guamá", "Poli", "15 Kg", "100,00", "50,00"],
                                    ["", "Jurunas", "Poli", "15 Kg", "100,00", "50,00"],
                                    ["", "<b>Marco</b>", "", "", "<b>400,00</b>", "<b>200,00</b>"],
                                    ["", "", "Cal", "5 Kg", "100,00", "50,00"],
                                    ["", "", "Fluor", "15 Kg", "100,00", "50,00"],
                                    ["", "", "Poli", "15 Kg", "100,00", "50,00"],
                                    ["", "", "Sódio", "5 Kg", "100,00", "50,00"],
                                    ["", "Matinha", "Poli", "15 Kg", "100,00", "50,00"],
                                    ["", "Nazaré", "Poli", "15 Kg", "100,00", "50,00"],
                                    ["", "<b>Pedreira</b>", "", "", "<b>300,00</b>", "<b>150,00</b>"],
                                    ["", "", "Fluor", "10 Kg", "100,00", "50,00"],
                                    ["", "", "Fluor", "15 Kg", "100,00", "50,00"],
                                    ["", "", "Poli", "15 Kg", "100,00", "50,00"],
                                    ["", "Pratinha", "Poli", "15 Kg", "100,00", "50,00"],
                                    ["", "Reduto", "Poli", "15 Kg", "100,00", "50,00"],
                                    ["", "São Brás", "Poli", "15 Kg", "100,00", "50,00"],
                                    ["", "Tapanã", "Poli", "15 Kg", "100,00", "50,00"],
                                    ["", "Telégrafo", "Poli", "15 Kg", "100,00", "50,00"],
                                    ["", "Tenoné", "Poli", "15 Kg", "100,00", "50,00"],
                                    ["", "Umarizal", "Poli", "15 Kg", "100,00", "50,00"],
                                    ["<b>Santarém</b>", "", "", "", "<b>500,00</b>", "<b>250,00</b>"],
                                    ["", "<b>Alter</b>", "", "", "<b>300,00</b>", "<b>150,00</b>"],
                                    ["", "", "Cal", "20 Kg", "100,00", "50,00"],
                                    ["", "", "Cloro", "10 Kg", "100,00", "50,00"],
                                    ["", "", "Poli", "25 Kg", "100,00", "50,00"],
                                    ["", "<b>Pedreira</b>", "", "", "<b>200,00</b>", "<b>100,00</b>"],
                                    ["", "", "Fluor", "25 Kg", "100,00", "50,00"],
                                    ["", "", "Sódio", "20 Kg", "100,00", "50,00"]
                                  ]
    end

    it "#salvar" do
      path = subject.salvar
      pdf = File.open "public/#{path}"

      expect(pdf).not_to be_nil
    end
  end
end
