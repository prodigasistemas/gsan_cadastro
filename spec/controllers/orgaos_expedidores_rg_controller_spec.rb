require 'rails_helper'

describe OrgaosExpedidoresRgController, type: :controller do
  render_views

  let(:json) { JSON.parse(response.body) }
  let!(:orgaos_expedidores_rg) { create_list(:orgao_expedidor_rg, 3) }

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
              "descricao"=>"Orgao Ex"
            }
        }
      end

      it "retorna dados da paginacao" do
        expect(json['page']['total']).to eq(3)
        expect(json['page']['total_pages']).to eq(1)
      end

      it "retorna lista de orgaos expedidores de RG" do
        expect(json['orgaos_expedidores_rg'].size).to eq(3)
        expect(json['orgaos_expedidores_rg'].collect{|l| l["descricao"]}).to include(orgaos_expedidores_rg.first.descricao)
      end
    end

    context "quando a consulta não retorna resultados" do
      let(:params) do
        {
          "query"=>
            {
              "descricao"=>"Nenhum orgao_expedidor_rg aqui"
            }
        }
      end

      it "retorna dados da paginacao" do
        expect(json['page']['total']).to eq(0)
        expect(json['page']['total_pages']).to eq(0)
      end

      it "retorna lista de ceps vazia" do
        expect(json['orgaos_expedidores_rg'].size).to eq(0)
      end
    end
  end

  describe "GET show" do
    it "retorna uma orgao_expedidor_rg" do
      get :show, id: 1, format: :json
      expect(json['descricao']).to eq orgaos_expedidores_rg.first.descricao
    end
  end

  describe "POST create" do
    context "quando cep é criado com sucesso" do
      let(:params) {
        {
          'orgao_expedidor_rg'=>attributes_for(:orgao_expedidor_rg).with_indifferent_access
        }
      }

      it "retorna sucesso" do
        post :create, params, format: :json
        expect(response).to be_success
      end
    end

    context "quando orgao_expedidor_rg não é criado" do
      let(:params) {
        {
          'orgao_expedidor_rg'=>attributes_for(:orgao_expedidor_rg, descricao: '').with_indifferent_access
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
    context "quando orgao expedidor de RG é atualizado com sucesso" do
      let(:params) {
        attributes_for(:orgao_expedidor_rg).with_indifferent_access
      }

      it "retorna a orgao_expedidor_rg" do
        put :update, id: 1, orgao_expedidor_rg: params, format: :json
        expect(response).to be_success
      end
    end

    context "quando orgao expedidor de RG não é atualizado" do
      let(:params) {
        attributes_for(:orgao_expedidor_rg, descricao: '').with_indifferent_access
      }

      it "retorna erros" do
        put :update, id: 1, orgao_expedidor_rg: params, format: :json
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end
end
