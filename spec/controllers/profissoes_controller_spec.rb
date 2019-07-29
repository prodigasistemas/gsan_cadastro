require 'rails_helper'

describe ProfissoesController, type: :controller do
  render_views

  let(:json) { JSON.parse(response.body) }
  let!(:profissoes) { create_list(:profissao, 3) }

  describe "GET index" do
    context "quando a consulta" do
      before do
        get :index, params: params, format: :json

        expect(response).to be_successful
        expect(json['page']['first_page']).to be true
        expect(json['page']['last_page']).to be true
        expect(json['page']['current_page']).to eq(1)
      end

      context "retorna resultados" do
        let(:params) do
          {
            "query"=>
              {
                "descricao"=>"Profissao"
              }
          }
        end

        it "retorna dados da paginacao" do
          expect(json['page']['total']).to eq(3)
          expect(json['page']['total_pages']).to eq(1)
        end

        it "retorna lista de profissoes" do
          expect(json['profissoes'].size).to eq(3)
          expect(json['profissoes'].collect{|l| l["descricao"]}).to include(profissoes.first.descricao)
        end
      end

      context "não retorna resultados" do
        let(:params) do
          {
            "query"=>
              {
                "descricao"=>"Nenhuma profissao aqui"
              }
          }
        end

        it "retorna dados da paginacao" do
          expect(json['page']['total']).to eq(0)
          expect(json['page']['total_pages']).to eq(0)
        end

        it "retorna lista de profissoes vazia" do
          expect(json['profissoes'].size).to eq(0)
        end
      end
    end

    context "quando a consulta não possuir filtros" do
      before do
        get :index, params: nil, format: :json
      end

      it "retorna a lista de profissoes" do
        expect(json['profissoes'].size).to eq 3
        expect(json['profissoes'].collect{|l| l["descricao"]}).to include(profissoes.first.descricao)
      end
    end
  end

  describe "GET show" do
    it "retorna uma profissao" do
      get :show, params: {id: 1}, format: :json
      expect(json['descricao']).to eq profissoes.first.descricao
    end
  end

  describe "POST create" do
    context "quando cep é criado com sucesso" do
      let(:params) {
        {
          'profissao'=>attributes_for(:profissao).with_indifferent_access
        }
      }

      it "retorna sucesso" do
        post :create, params: params, format: :json
        expect(response).to be_successful
      end
    end

    context "quando profissao não é criado" do
      let(:params) {
        {
          'profissao'=>attributes_for(:profissao, descricao: '').with_indifferent_access
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
    context "quando profissao é atualizado com sucesso" do
      let(:params) {
        attributes_for(:profissao).with_indifferent_access
      }

      it "retorna a profissao" do
        put :update, params: {id: 1, profissao: params}, format: :json
        expect(response).to be_successful
      end
    end

    context "quando profissaonão é atualizado" do
      let(:params) {
        attributes_for(:profissao, descricao: '').with_indifferent_access
      }

      it "retorna erros" do
        put :update, params: {id: 1, profissao: params}, format: :json
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end
end
