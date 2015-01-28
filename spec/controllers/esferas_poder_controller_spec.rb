require 'rails_helper'

describe EsferasPoderController, type: :controller do
  render_views

  let(:json) { JSON.parse(response.body) }
  let!(:esferas_poder) { create_list(:esfera_poder, 3) }

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
              "descricao"=>"Esfera"
            }
        }
      end

      it "retorna dados da paginacao" do
        expect(json['page']['total']).to eq(3)
        expect(json['page']['total_pages']).to eq(1)
      end

      it "retorna lista de ceps" do
        expect(json['esferas_poder'].size).to eq(3)
        expect(json['esferas_poder'].collect{|l| l["descricao"]}).to include(esferas_poder.first.descricao)
      end
    end

    context "quando a consulta não retorna resultados" do
      let(:params) do
        {
          "query"=>
            {
              "descricao"=>"Nenhuma esfera aqui"
            }
        }
      end

      it "retorna dados da paginacao" do
        expect(json['page']['total']).to eq(0)
        expect(json['page']['total_pages']).to eq(0)
      end

      it "retorna lista de ceps vazia" do
        expect(json['esferas_poder'].size).to eq(0)
      end
    end
  end

  describe "GET show" do
    it "retorna uma esfera de poder" do
      get :show, id: 1, format: :json
      expect(json['descricao']).to eq esferas_poder.first.descricao
    end
  end

  describe "POST create" do
    context "quando cep é criado com sucesso" do
      let(:params) {
        {
          'esfera_poder'=>attributes_for(:esfera_poder).with_indifferent_access
        }
      }

      it "retorna a esfera poder" do
        post :create, params, format: :json
        expect(response).to be_success
      end
    end

    context "quando cep não é criado" do
      let(:params) {
        {
          'esfera_poder'=>attributes_for(:esfera_poder, descricao: '').with_indifferent_access
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
    context "quando esfera de poder é atualizado com sucesso" do
      let(:params) {
        attributes_for(:esfera_poder).with_indifferent_access
      }

      it "retorna o cep" do
        put :update, id: 1, esfera_poder: params, format: :json
        expect(response).to be_success
      end
    end

    context "quando esfera de poder não é atualizado" do
      let(:params) {
        attributes_for(:esfera_poder, descricao: '').with_indifferent_access
      }

      it "retorna erros" do
        put :update, id: 1, esfera_poder: params, format: :json
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end
end
