require 'spec_helper'

describe RelatoriosController, type: :controller do
  let(:params) {
    {
      cabecalho: [
        { name: "municipio",      description: "Município",         align: "left",    type: "string" },
        { name: "data",           description: "Data",              align: "left",    type: "date" },
        { name: "descricao",      description: "Produto",           align: "left",    type: "string" },
        { name: "unidadeMedida",  description: "Unidade de Medida", align: "center",  type: "string" },
        { name: "valor",          description: "Valor (R$)",        align: "right",   type: "money" }
      ],
      dados: [
        { municipio: "Belem",     data: "2015-05-05",    descricao: "Cal",   unidadeMedida: "5 Kg",  valor: "100,00" },
        { municipio: "Santarém",  data: "2015-10-05",    descricao: "Cloro", unidadeMedida: "10 Kg", valor: "100,00" },
        { municipio: "Belem",     data: "2015-05-05",    descricao: "Sódio", unidadeMedida: "5 Kg",  valor: "100,00" },
        { municipio: "Belem",     data: "2015-05-05",    descricao: "Fluor", unidadeMedida: "15 Kg", valor: "100,00" },
        { municipio: "Belem",     data: "2015-06-05",    descricao: "Fluor", unidadeMedida: "15 Kg", valor: "100,00" },
        { municipio: "Santarém",  data: "2015-10-05",    descricao: "Cal",   unidadeMedida: "20 Kg", valor: "100,00" },
        { municipio: "Belem",     data: "2015-05-05",    descricao: "Poli",  unidadeMedida: "15 Kg", valor: "100,00" }
       ],
      grupos: [ { name: "municipio" }, { name: "data" } ],
      totalizadores: [ {name: "valor"} ]
    }
  }

  describe "POST create" do
    it "respond 422" do
      post :create

      expect(response.code).to eq "422"
    end

    it "sem params" do
      post :create

      expect(JSON.parse(response.body)["error"]).to_not be_nil
    end

    it "com params" do
      post :create, params

      expect(response.body).to eq({url: "http://#{request.host_with_port}/relatorios/novo_relatorio.xls"}.to_json)
    end

    context "formato" do
      it "formato pdf" do
        params[:formato] = "pdf"

        post :create, params

        expect(response.body).to eq({url: "http://#{request.host_with_port}/relatorios/novo_relatorio.pdf"}.to_json)
      end

      it "formato xls" do
        params[:formato] = "xls"

        post :create, params

        expect(response.body).to eq({url: "http://#{request.host_with_port}/relatorios/novo_relatorio.xls"}.to_json)
      end
    end
  end
end
