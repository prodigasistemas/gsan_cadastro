require 'rails_helper'

describe Relatorio::Base, type: :model do
  let(:json_agrupado) {
    {
      cabecalho: [
        { name: "municipio",      description: "Município",         align: "left" },
        { name: "localidade",     description: "Localidade",        align: "left" },
        { name: "descricao",      description: "Produto",           align: "left" },
        { name: "unidadeMedida",  description: "Unidade de Medida", align: "center" },
        { name: "valor",          description: "Valor (R$)",        align: "right" }
      ],
      dados: [
        { municipio: "Belém",     localidade: "Marco",    descricao: "Cal",   unidadeMedida: "5 Kg",  valor: 100.0 },
        { municipio: "Belém",     localidade: "Marco",    descricao: "Fluor", unidadeMedida: "15 Kg", valor: 100.0 },
        { municipio: "Belém",     localidade: "Marco",    descricao: "Poli",  unidadeMedida: "15 Kg", valor: 100.0 },
        { municipio: "Belém",     localidade: "Marco",    descricao: "Sódio", unidadeMedida: "5 Kg",  valor: 100.0 },
        { municipio: "Belém",     localidade: "Pedreira", descricao: "Fluor", unidadeMedida: "15 Kg", valor: 100.0 },
        { municipio: "Santarém",  localidade: "Alter",    descricao: "Cal",   unidadeMedida: "20 Kg", valor: 100.0 },
        { municipio: "Santarém",  localidade: "Alter",    descricao: "Cloro", unidadeMedida: "10 Kg", valor: 100.0 }
      ],
      grupos: [
        { name: "municipio" },
        { name: "localidade" }
      ],
      totalizadores: [ { name: "valor" } ],
      resumo:{
        cabecalho: [
            {name: "texto"      , description: ""      , align: "left" },
            {name: "valorAgua"  , description: "Agua"  , align: "right"},
            {name: "valorEsgoto", description: "Esgoto", align: "right"},
            {name: "valorTotal" , description: "Total" , align: "right"}
        ],
        dados:[
          {texto: "Valor a ser repassado", valorAgua: "5555.555,99", valorEsgoto: "333.448,99", valorTotal: "123.444,89"}
        ]
      }
    }
  }

  let(:dados) {
    [
      ["Belém",     "Marco",    "Cal",    "5 Kg",   100.0],
      ["Belém",     "Marco",    "Fluor",  "15 Kg",  100.0],
      ["Belém",     "Marco",    "Poli",   "15 Kg",  100.0],
      ["Belém",     "Marco",    "Sódio",  "5 Kg",   100.0],
      ["Belém",     "Pedreira", "Fluor",  "15 Kg",  100.0],
      ["Santarém",  "Alter",    "Cal",    "20 Kg",  100.0],
      ["Santarém",  "Alter",    "Cloro",  "10 Kg",  100.0]
    ]
  }

  let(:dados_agrupados) {
    [
      ["Total",     "-",        "-",      "-",      700.0],
      ["Belém",     "-",        "-",      "-",      500.0],
      ["Belém",     "Marco",    "-",      "-",      400.0],
      ["Belém",     "Marco",    "Cal",    "5 Kg",   100.0],
      ["Belém",     "Marco",    "Fluor",  "15 Kg",  100.0],
      ["Belém",     "Marco",    "Poli",   "15 Kg",  100.0],
      ["Belém",     "Marco",    "Sódio",  "5 Kg",   100.0],
      ["Belém",     "Pedreira", "Fluor",  "15 Kg",  100.0],
      ["Santarém",  "-",        "-",      "-",      200.0],
      ["Santarém",  "Alter",    "-",      "-",      200.0],
      ["Santarém",  "Alter",    "Cal",    "20 Kg",  100.0],
      ["Santarém",  "Alter",    "Cloro",  "10 Kg",  100.0]
    ]
  }

  let(:resumo) {
    [
      ["","Agua","Esgoto","Total"],
      ["Valor a ser repassado", "5555.555,99", "333.448,99", "123.444,89"]
    ]
  }

  it "#monta_dados" do
    expect(subject.monta_dados(json_agrupado)).to eq dados
  end

  it "#dados_agrupados" do
    expect(subject.dados_ordenados(json_agrupado)).to eq dados_agrupados
  end

  it "#monta_resumo" do
    expect(subject.monta_resumo(json_agrupado)).to eq resumo
  end
end
