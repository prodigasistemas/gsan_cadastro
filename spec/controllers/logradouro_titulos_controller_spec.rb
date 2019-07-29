require 'rails_helper'

describe LogradouroTitulosController, type: :controller do
  render_views

  let(:json) { JSON.parse(response.body) }
  let!(:logradouro_titulos) { create_list(:logradouro_titulo, 3) }

  describe "GET index" do
    before do
      get :index, params: params, format: :json

      expect(response).to be_successful
      expect(json['page']['first_page']).to be true
      expect(json['page']['last_page']).to be true
      expect(json['page']['current_page']).to eq(1)
    end

    context "quando a consulta retorna resultados" do
      let(:params) do
        {
          "query"=>
            {
              "descricao"=>"titulo"
            }
        }
      end

      it "retorna dados da paginacao" do
        expect(json['page']['total']).to eq(3)
        expect(json['page']['total_pages']).to eq(1)
      end

      it "retorna lista de titulos de logradouro" do
        expect(json['logradouro_titulos'].size).to eq(3)
        expect(json['logradouro_titulos'].collect{|l| l["descricao"]}).to include(logradouro_titulos.first.descricao)
      end
    end

    context "quando a consulta não retorna resultados" do
      let(:params) do
        {
          "query"=>
            {
              "descricao"=>"Nenhum titulo aqui"
            }
        }
      end

      it "retorna dados da paginacao" do
        expect(json['page']['total']).to eq(0)
        expect(json['page']['total_pages']).to eq(0)
      end

      it "retorna lista de ceps vazia" do
        expect(json['logradouro_titulos'].size).to eq(0)
      end
    end
  end

  describe "GET show" do
    it "retorna um titulo de logradouro" do
      get :show, params: {id: 1}, format: :json
      expect(json['descricao']).to eq logradouro_titulos.first.descricao
    end
  end

  describe "POST create" do
    context "quando cep é criado com sucesso" do
      let(:params) {
        {
          'logradouro_titulo'=>attributes_for(:logradouro_titulo).with_indifferent_access
        }
      }

      it "retorna sucesso" do
        post :create, params: params, format: :json
        expect(response).to be_successful
      end
    end

    context "quando titulo de lograoduro não é criado" do
      let(:params) {
        {
          'logradouro_titulo'=>attributes_for(:logradouro_titulo, descricao: '').with_indifferent_access
        }
      }

      it "retorna erros" do
        post :create, params: params, format: :json
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end

  describe "PUT update" do
    context "quando titulo de logradouro é atualizado com sucesso" do
      let(:params) {
        attributes_for(:logradouro_titulo).with_indifferent_access
      }

      it "retorna a logradouro_titulo" do
        put :update, params: {id: 1, logradouro_titulo: params}, format: :json
        expect(response).to be_successful
      end
    end

    context "quando titulo de logradouro não é atualizado" do
      let(:params) {
        attributes_for(:logradouro_titulo, descricao: '').with_indifferent_access
      }

      it "retorna erros" do
        put :update, params: {id: 1, logradouro_titulo: params}, format: :json
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end
end
