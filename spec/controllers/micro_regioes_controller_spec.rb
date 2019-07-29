require 'rails_helper'

describe MicroRegioesController, type: :controller do
  render_views

  let!(:marajo)     { create(:micro_regiao, nome: 'MARAJO') }
  let!(:tapajos)    { create(:micro_regiao, nome: 'TAPAJOS') }
  let!(:tocantins)  { create(:micro_regiao, nome: 'TOCANTINS', ativo: 2) }
  let!(:regiao)     { create(:regiao) }

  describe "GET index" do
    context "quando a consulta possuir filtros" do
      let(:params) do
        {
          "query" =>
            {
              "nome" => "MARAJO",
              "regiao_id" => 1
            }
        }
      end

      before do
        get :index, params: params, format: :json
      end

      it "retorna a lista de micro regiões ativas" do
        expect(json['micro_regioes'].size).to eq 1
        expect(json['micro_regioes'].collect{|l| l["nome"]}).to include(marajo.nome)
      end

      it "retorna dados da paginação" do
        expect(json['page']['first_page']).to be true
        expect(json['page']['last_page']).to be true
        expect(json['page']['current_page']).to eq(1)
        expect(json['page']['total']).to eq(1)
        expect(json['page']['total_pages']).to eq(1)
      end
    end

    context "quando a consulta não possuir filtros" do
      it "não retorna atributos da paginação" do
        get :index, format: :json
        expect(json['page']).to be_nil
      end
    end
  end

  describe "GET show" do
    it "retorna uma micro região" do
      get :show, params: {id: marajo.id}, format: :json
      expect(json['nome']).to eq marajo.nome
    end
  end

  describe "POST create" do
    context "quando a micro região é criada com sucesso" do
      let(:params) do
        {
          'micro_regiao' => attributes_for(:micro_regiao, regiao_id: regiao.id).with_indifferent_access
        }
      end

      it "cria uma micro região" do
        post :create, params: params, format: :json
        expect(json['nome']).to eq params['micro_regiao']['nome']
      end
    end

    context "quando a micro região não é criada" do
      let(:params) do
        {
          'micro_regiao' => attributes_for(:micro_regiao).with_indifferent_access
        }
      end

      it "mostra erros de validação" do
        post :create, params: params, format: :json
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end

  describe "PUT update" do
    context "quando a micro região é atualizada com sucesso" do
      let(:params) {
        attributes_for(:micro_regiao, regiao_id: regiao.id).with_indifferent_access
      }

      it "retorna a micro região" do
        put :update, params: {id: marajo, micro_regiao: params}, format: :json
        marajo.reload
        expect(json['nome']).to eq marajo.nome
      end
    end

    context "quando a micro região não é atualizada" do
      let(:params) {
        attributes_for(:micro_regiao).with_indifferent_access
      }

      it "retorna erros" do
        put :update, params: {id: 1, micro_regiao: params}, format: :json
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end
end