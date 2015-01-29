require 'rails_helper'

describe RamosAtividadesController, type: :controller do
  render_views

  let(:json) { JSON.parse(response.body) }
  let!(:ramos_atividade) { create_list(:ramo_atividade, 3) }

  describe "GET index" do
    context "quando a consulta" do
      before do
        get :index, params, format: :json

        expect(response).to be_success
        expect(json['page']['first_page']).to be true
        expect(json['page']['last_page']).to be true
        expect(json['page']['current_page']).to eq(1)
      end

      context "retorna resultados" do
        let(:params) do
          {
            "query"=>
              {
                "descricao"=>"Ramo de a"
              }
          }
        end

        it "retorna dados da paginacao" do
          expect(json['page']['total']).to eq(3)
          expect(json['page']['total_pages']).to eq(1)
        end

        it "retorna lista de ramos de atividades" do
          expect(json['ramos_atividade'].size).to eq(3)
          expect(json['ramos_atividade'].collect{|l| l["descricao"]}).to include(ramos_atividade.first.descricao)
        end
      end

      context "não retorna resultados" do
        let(:params) do
          {
            "query"=>
              {
                "descricao"=>"Nenhuma ramo_atividade aqui"
              }
          }
        end

        it "retorna dados da paginacao" do
          expect(json['page']['total']).to eq(0)
          expect(json['page']['total_pages']).to eq(0)
        end

        it "retorna lista de  ramos de atividades vazia" do
          expect(json['ramos_atividade'].size).to eq(0)
        end
      end
    end

    context "quando a consulta não possuir filtros" do
      before do
        get :index, nil, format: :json
      end

      it "retorna a lista de  ramos de atividades" do
        expect(json['ramos_atividade'].size).to eq 3
        expect(json['ramos_atividade'].collect{|l| l["descricao"]}).to include(ramos_atividade.first.descricao)
      end
    end
  end

  describe "GET show" do
    it "retorna uma ramo_atividade" do
      get :show, id: 1, format: :json
      expect(json['descricao']).to eq ramos_atividade.first.descricao
    end
  end

  describe "POST create" do
    context "quando cep é criado com sucesso" do
      let(:params) {
        {
          'ramo_atividade'=>attributes_for(:ramo_atividade).with_indifferent_access
        }
      }

      it "retorna sucesso" do
        post :create, params, format: :json
        expect(response).to be_success
      end
    end

    context "quando ramo_atividade não é criado" do
      let(:params) {
        {
          'ramo_atividade'=>attributes_for(:ramo_atividade, descricao: '').with_indifferent_access
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
    context "quando ramo de atividade é atualizado com sucesso" do
      let(:params) {
        attributes_for(:ramo_atividade).with_indifferent_access
      }

      it "retorna a ramo_atividade" do
        put :update, id: 1, ramo_atividade: params, format: :json
        expect(response).to be_success
      end
    end

    context "quando ramo de atividade não é atualizado" do
      let(:params) {
        attributes_for(:ramo_atividade, descricao: '').with_indifferent_access
      }

      it "retorna erros" do
        put :update, id: 1, ramo_atividade: params, format: :json
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end
end
