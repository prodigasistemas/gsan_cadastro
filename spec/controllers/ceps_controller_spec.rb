require 'rails_helper'

describe CepsController, type: :controller do
  render_views

  let(:json) { JSON.parse(response.body) }
  let!(:ceps) { create_list(:cep, 3) }

  describe "GET index" do
    before do
      get :index, params, format: :json

      expect(response).to be_success
      expect(json['page']['first_page']).to be true
      expect(json['page']['last_page']).to be true
      expect(json['page']['current_page']).to eq(1)
    end

    context "quando a consulta retorna resultados" do
      let(:params) do
        {
          "query"=>
            {
              "tipo_id"=>"1",
              "filtro_municipio"=>"bele", 
              "uf"=>"PA", 
              "filtro_logradouro"=>"MATA", 
              "tipo_logradouro"=>"RUA"
            }
        }
      end

      it "retorna dados da paginacao" do
        expect(json['page']['total']).to eq(3)
        expect(json['page']['total_pages']).to eq(1)
      end

      it "retorna lista de ceps" do
        expect(json['ceps'].size).to eq(3)
        expect(json['ceps'].collect{|l| l["codigo"]}).to include(ceps.first.codigo)
      end
    end

    context "quando a consulta não retorna resultados" do
      let(:params) do
        {
          "query"=>
            {
              "tipo_id"=>"2"
            }
        }
      end

      it "retorna dados da paginacao" do
        expect(json['page']['total']).to eq(0)
        expect(json['page']['total_pages']).to eq(0)
      end

      it "retorna lista de ceps vazia" do
        expect(json['ceps'].size).to eq(0)
      end
    end
  end
end