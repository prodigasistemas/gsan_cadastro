require 'rails_helper'

describe EnderecoReferenciasController, type: :controller do
  render_views

  let!(:esquina)          { create(:endereco_referencia, descricao: 'ESQUINA') }
  let!(:quadra)           { create(:endereco_referencia, descricao: 'QUADRA') }

  describe "GET index" do
    context "quando a consulta não possuir filtros" do
      before do
        get :index, nil, format: :json
      end

      it "retorna a lista de referências do endereço" do
        expect(json.size).to eq 2
        expect(json.collect{|l| l["descricao"]}).to include(esquina.descricao)
      end
    end
  end
end