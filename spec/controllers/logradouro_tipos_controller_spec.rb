require 'rails_helper'

describe LogradouroTiposController, type: :controller do
  render_views

  let(:json) { JSON.parse(response.body) }
  let!(:logradouro_tipos) { create_list(:logradouro_tipo, 3) }

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
              "descricao"=>"tipo"
            }
        }
      end

      it "retorna dados da paginacao" do
        expect(json['page']['total']).to eq(3)
        expect(json['page']['total_pages']).to eq(1)
      end

      it "retorna lista de tipos de logradouro" do
        expect(json['logradouro_tipos'].size).to eq(3)
        expect(json['logradouro_tipos'].collect{|l| l["descricao"]}).to include(logradouro_tipos.first.descricao)
      end
    end

    context "quando a consulta não retorna resultados" do
      let(:params) do
        {
          "query"=>
            {
              "descricao"=>"Nenhum tipo aqui"
            }
        }
      end

      it "retorna dados da paginacao" do
        expect(json['page']['total']).to eq(0)
        expect(json['page']['total_pages']).to eq(0)
      end

      it "retorna lista de ceps vazia" do
        expect(json['logradouro_tipos'].size).to eq(0)
      end
    end
  end

  describe "GET show" do
    it "retorna um tipo de logradouro" do
      get :show, id: 1, format: :json
      expect(json['descricao']).to eq logradouro_tipos.first.descricao
    end
  end

  describe "POST create" do
    context "quando cep é criado com sucesso" do
      let(:params) {
        {
          'logradouro_tipo'=>attributes_for(:logradouro_tipo).with_indifferent_access
        }
      }

      it "retorna sucesso" do
        post :create, params, format: :json
        expect(response).to be_success
      end
    end

    context "quando tipo de lograoduro não é criado" do
      let(:params) {
        {
          'logradouro_tipo'=>attributes_for(:logradouro_tipo, descricao: '').with_indifferent_access
        }
      }

      it "retorna erros" do
        post :create, params, format: :json
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end

  describe "PUT update" do
    context "quando tipo de logradouro é atualizado com sucesso" do
      let(:params) {
        attributes_for(:logradouro_tipo).with_indifferent_access
      }

      it "retorna a logradouro_tipo" do
        put :update, id: 1, logradouro_tipo: params, format: :json
        expect(response).to be_success
      end
    end

    context "quando tipo de logradouro não é atualizado" do
      let(:params) {
        attributes_for(:logradouro_tipo, descricao: '').with_indifferent_access
      }

      it "retorna erros" do
        put :update, id: 1, logradouro_tipo: params, format: :json
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end
end
