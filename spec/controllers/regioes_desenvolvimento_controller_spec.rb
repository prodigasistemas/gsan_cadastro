require 'rails_helper'

describe RegioesDesenvolvimentoController, type: :controller do
  render_views
  let!(:baixo_amazonas)   { create(:regiao_desenvolvimento, nome: 'BAIXO AMAZONAS') }
  let!(:nodeste_paraense) { create(:regiao_desenvolvimento, nome: 'NORDESTE PARAENSE') }
  let!(:sudeste_paraense) { create(:regiao_desenvolvimento, nome: 'SUDESTE PARAENSE', ativo: 2) }

  describe "GET index" do
    context "quando a consulta possuir filtros" do
      let(:params) do
        {
          "query" =>
            {
              "nome" => "BAIXO AMAZONAS"
            }
        }
      end

      before do
        get :index, params: params, format: :json
      end

      it "retorna a lista de regiões de desenvolvimento ativas" do
        expect(json['regioes_desenvolvimento'].size).to eq 1
        expect(json['regioes_desenvolvimento'].collect{|l| l["nome"]}).to include(baixo_amazonas.nome)
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
        get :index, params: nil, format: :json
        expect(json['page']).to be_nil
      end
    end
  end

  describe "GET show" do
    it "retorna uma região de desenvolvimento" do
      get :show, params: {id: baixo_amazonas.id}, format: :json
      expect(json['nome']).to eq baixo_amazonas.nome
    end
  end

  describe "POST create" do
    context "quando a região de desenvolvimento é criada com sucesso" do
      let(:params) do
        {
          'regiao_desenvolvimento' => attributes_for(:regiao_desenvolvimento).with_indifferent_access
        }
      end

      it "cria uma região de desenvolvimento" do
        post :create, params: params, format: :json
        expect(json['nome']).to eq params['regiao_desenvolvimento']['nome']
      end
    end

    context "quando a região de desenvolvimento não é criada" do
      let(:params) do
        {
          'regiao_desenvolvimento' => attributes_for(:regiao_desenvolvimento, nome: nil).with_indifferent_access
        }
      end

      it "mostra erros de validação" do
        post :create, params: params, format: :json
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end

  describe "GET show" do
    it "retorna uma região de desenvolvimento" do
      get :show, params: {id: baixo_amazonas.id}, format: :json
      expect(json['nome']).to eq baixo_amazonas.nome
    end
  end

  describe "PUT update" do
    context "quando a região de desenvolvimento é atualizada com sucesso" do
      let(:params) {
        attributes_for(:regiao_desenvolvimento).with_indifferent_access
      }

      it "retorna a região de desenvolvimento" do
        put :update, params: {id: baixo_amazonas, regiao_desenvolvimento: params}, format: :json
        baixo_amazonas.reload
        expect(json['nome']).to eq baixo_amazonas.nome
      end
    end

    context "quando a micro região não é atualizada" do
      let(:params) {
        attributes_for(:regiao_desenvolvimento, nome: nil).with_indifferent_access
      }

      it "retorna erros" do
        put :update, params: {id: 1, regiao_desenvolvimento: params}, format: :json
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end
end