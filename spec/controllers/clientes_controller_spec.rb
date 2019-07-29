require 'rails_helper'

describe ClientesController, type: :controller do
  render_views

  let!(:pessoa_fisica)              { create(:cliente_tipo, :pessoa_fisica) }
  let!(:pessoa_sexo)               { create(:pessoa_sexo) }
  let!(:alberto)                   { create(:cliente, nome: 'ALBERTO', cpf: "82512726290") }
  let!(:roberto)                   { create(:cliente, nome: 'ROBERTO', cpf: "72844726429") }

  describe "GET index" do
    context "quando a consulta possuir filtros" do
      let(:params) do
        {
          "query" =>
            {
              "nome" => "ALBERTO"
            }
        }
      end

      before do
        get :index, params: params, format: :json
      end

      it "retorna a lista de clientes ativos" do
        expect(json['clientes'].size).to eq 1
        expect(json['clientes'].collect{|l| l["nome"]}).to include(alberto.nome)
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
      before do
        get :index, params: nil, format: :json
      end

      it "retorna a lista de clientes ativos" do
        expect(json['clientes'].size).to eq 2
        expect(json['clientes'].collect{|l| l["nome"]}).to include(alberto.nome)
      end
    end
  end

  describe "GET show" do
    it "retorna um cliente" do
      get :show, params: {id: alberto.id}, format: :json
      expect(json['nome']).to eq alberto.nome
    end
  end

  describe "POST create" do
    context "quando o cliente é criado com sucesso" do
      let(:params) do
        {
          'cliente' => attributes_for(
            :cliente,
            cliente_tipo_id: pessoa_fisica.id,
            pessoa_sexo_id: pessoa_sexo.id
          ).with_indifferent_access
        }
      end

      it "cria um cliente" do
        post :create, params: params, format: :json
        expect(response.status).to eq 200
      end
    end

    context "quando o cliente não é criado" do
      let(:params) do
        {
          'cliente' => attributes_for(:cliente).with_indifferent_access
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
    context "quando o cliente é atualizado com sucesso" do
      let(:params) {
        attributes_for(
          :cliente,
          cliente_tipo_id: pessoa_fisica.id,
          pessoa_sexo_id: pessoa_sexo.id
        ).with_indifferent_access
      }

      it "altera o cliente" do
        put :update, params: {id: alberto, cliente: params}, format: :json
        expect(response.status).to eq 200
      end
    end

    context "quando o cliente não é atualizado" do
      let(:params) {
        attributes_for(:cliente, nome: nil).with_indifferent_access
      }

      it "retorna erros" do
        put :update, params: {id: 1, cliente: params}, format: :json
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end
end