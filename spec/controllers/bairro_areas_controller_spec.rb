require 'rails_helper'

describe BairroAreasController, type: :controller do
  render_views

  let!(:centro)               { create(:bairro_area, nome: 'CENTRO') }
  let!(:industrial)           { create(:bairro_area, nome: 'INDUSTRIAL') }
  let!(:bairro)               { create(:bairro) }
  let!(:distrito_operacional) { create(:distrito_operacional) }

  describe "GET index" do
    context "quando a consulta possuir filtros" do
      let(:params) do
        {
          "query" =>
            {
              "nome" => "CENTRO"
            }
        }
      end

      before do
        get :index, params: params, format: :json
      end

      it "retorna a lista de áreas do bairro" do
        expect(json['bairro_areas'].size).to eq 1
        expect(json['bairro_areas'].collect{|l| l["nome"]}).to include(centro.nome)
      end
    end

    context "quando a consulta não possuir filtros" do
      before do
        get :index, params: nil, format: :json
      end

      it "retorna a lista de áreas do bairro" do
        expect(json['bairro_areas'].size).to eq 2
        expect(json['bairro_areas'].collect{|l| l["nome"]}).to include(centro.nome)
      end
    end
  end
end