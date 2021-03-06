require 'rails_helper'

describe LogradourosController, type: :controller do
  render_views

  let!(:logradouro_titulo)        { create(:logradouro_titulo) }
  let!(:logradouro_tipo)          { create(:logradouro_tipo) }
  let!(:municipio)                { create(:municipio) }
  let!(:arabola)                  { create(:logradouro, nome: 'ARABOLA') }
  let!(:berilo)                   { create(:logradouro, nome: 'BERILO') }

  describe "GET index" do
    context "quando a consulta possuir filtros" do
      let(:params) do
        {
          "query" =>
            {
              "nome" => "ARABOLA"
            }
        }
      end

      before do
        get :index, params: params, format: :json
      end

      it "retorna a lista de logradouros ativos" do
        expect(json['logradouros'].size).to eq 1
        expect(json['logradouros'].collect{|l| l["nome"]}).to include(arabola.nome)
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

      it "retorna a lista de logradouros ativos" do
        expect(json['logradouros'].size).to eq 2
        expect(json['logradouros'].collect{|l| l["nome"]}).to include(arabola.nome)
      end
    end
  end

  describe "GET show" do
    it "retorna um logradouro" do
      get :show, params: {id: arabola.id}, format: :json
      expect(json['nome']).to eq arabola.nome
    end
  end

  describe "POST create" do
    context "quando o logradouro é criado com sucesso" do
      let(:params) do
        {
          'logradouro' => attributes_for(
            :logradouro,
            logradouro_titulo_id: logradouro_titulo.id,
            logradouro_tipo_id: logradouro_tipo.id,
            municipio_id: municipio.id
          ).with_indifferent_access
        }
      end

      it "cria um logradouro" do
        post :create, params: params, format: :json
        expect(response.status).to eq 200
      end
    end

    context "quando o logradouro não é criado" do
      let(:params) do
        {
          'logradouro' => attributes_for(:logradouro).with_indifferent_access
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
    context "quando o logradouro é atualizado com sucesso" do
      let(:params) {
        attributes_for(
          :logradouro,
          logradouro_titulo_id: logradouro_titulo.id,
          logradouro_tipo_id: logradouro_tipo.id,
          municipio_id: municipio.id
        ).with_indifferent_access
      }

      it "altera o logradouro" do
        put :update, params: {id: arabola, logradouro: params}, format: :json
        expect(response.status).to eq 200
      end
    end

    context "quando o logradouro não é atualizado" do
      let(:params) {
        attributes_for(:logradouro, nome: nil).with_indifferent_access
      }

      it "retorna erros" do
        put :update, params: {id: 1, logradouro: params}, format: :json
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end
end