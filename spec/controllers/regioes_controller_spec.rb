require 'rails_helper'

describe RegioesController, type: :controller do
  render_views

  describe "GET index" do
    let!(:regioes) { [create(:regiao), create(:regiao, nome: 'CENTRO', ativo: 2)] }

    context "quando a consulta possuir filtros" do
      let(:params) do
        {
          "query"=>{ "nome"=>"NORTE" }
        }
      end

      before do
        get :index, params, format: :json
      end

      it "retorna a lista de regiões de acordo com os dados dos filtros" do
        expect(json['regioes'].size).to eq 1
        expect(json['regioes'].collect{|l| l["nome"]}).to include('NORTE')
      end

      it_behaves_like "com dados da paginacao"
    end

    context "quando a consulta não possuir filtros" do
      it_behaves_like "sem dados da paginacao"
    end
  end
end