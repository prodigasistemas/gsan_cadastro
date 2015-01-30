require 'rails_helper'

describe DistritoOperacionaisController, type: :controller do
  render_views

  let!(:distrito_geral) { create(:distrito_operacional) }
  let!(:distrito_um) { create(:distrito_operacional, descricao: "DISTRITO 1", abreviacao: "D1") }

  describe "GET index" do
    context "quando a consulta não possuir filtros" do
      before do
        get :index, nil, format: :json
      end

      it "retorna a lista de distritos operacionais" do
        expect(json["distrito_operacionais"].size).to eq 2
        expect(json["distrito_operacionais"].collect{|l| l["descricao"]}).to include(distrito_geral.descricao)
      end
    end
  end
end
