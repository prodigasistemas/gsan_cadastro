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

  describe "GET show" do
    it "retorna um cep" do
      get :show, id: 1, format: :json
      expect(json['codigo']).to eq ceps.first.codigo
    end
  end

  describe "POST create" do
    let(:municipio) { create(:municipio) }

    context "quando cep é criado com sucesso" do
      let(:params) { 
        {
          'cep'=>attributes_for(:cep).with_indifferent_access
        }
      }

      it "retorna o cep" do
        post :create, params, format: :json
        expect(json['codigo']).to eq params['cep']['codigo']
      end
    end

    context "quando cep não é criado" do
      let(:params) { 
        { 
          'cep'=>attributes_for(:cep, codigo: '').with_indifferent_access 
        } 
      }

      it "retorna erros" do
        post :create, params, format: :json
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end

  describe "GET edit" do
    let(:cep) { ceps.first }
    let!(:municipio) { create(:municipio, nome: 'BELEM') }
    let!(:bairros) { create_list(:bairro, 3, municipio: municipio) }

    it "retorna um cep" do
      get :edit, id: 1, format: :json
      expect(json['cep']['codigo']).to eq ceps.first.codigo
    end

    it "retorna lista de bairros do municipio ao qual pertence o cep" do
      get :edit, id: 1, format: :json
      expect(json['bairros'].size).to eq bairros.size
    end
  end
end