require 'rails_helper'

describe EnderecosReferenciaController, type: :controller do
  render_views

  let(:json) { JSON.parse(response.body) }
  let!(:enderecos_referencia) { create_list(:endereco_referencia, 3) }

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
              "descricao"=>"End Refe"
            }
        }
      end

      it "retorna dados da paginacao" do
        expect(json['page']['total']).to eq(3)
        expect(json['page']['total_pages']).to eq(1)
      end

      it "retorna lista de ceps" do
        expect(json['enderecos_referencia'].size).to eq(3)
        expect(json['enderecos_referencia'].collect{|l| l["descricao"]}).to include(enderecos_referencia.first.descricao)
      end
    end

    context "quando a consulta não retorna resultados" do
      let(:params) do
        {
          "query"=>
            {
              "descricao"=>"Nenhum endereco_referencia aqui"
            }
        }
      end

      it "retorna dados da paginacao" do
        expect(json['page']['total']).to eq(0)
        expect(json['page']['total_pages']).to eq(0)
      end

      it "retorna lista de ceps vazia" do
        expect(json['enderecos_referencia'].size).to eq(0)
      end
    end
  end

  describe "GET show" do
    it "retorna uma endereco_referencia" do
      get :show, id: 1, format: :json
      expect(json['descricao']).to eq enderecos_referencia.first.descricao
    end
  end

  describe "POST create" do
    context "quando cep é criado com sucesso" do
      let(:params) {
        {
          'endereco_referencia'=>attributes_for(:endereco_referencia).with_indifferent_access
        }
      }

      it "retorna sucesso" do
        post :create, params, format: :json
        expect(response).to be_success
      end
    end

    context "quando endereco_referencia não é criado" do
      let(:params) {
        {
          'endereco_referencia'=>attributes_for(:endereco_referencia, descricao: '').with_indifferent_access
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
    context "quando endereco de referencia é atualizado com sucesso" do
      let(:params) {
        attributes_for(:endereco_referencia).with_indifferent_access
      }

      it "retorna a endereco_referencia" do
        put :update, id: 1, endereco_referencia: params, format: :json
        expect(response).to be_success
      end
    end

    context "quando endereco de referencia não é atualizado" do
      let(:params) {
        attributes_for(:endereco_referencia, descricao: '').with_indifferent_access
      }

      it "retorna erros" do
        put :update, id: 1, endereco_referencia: params, format: :json
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end
end
