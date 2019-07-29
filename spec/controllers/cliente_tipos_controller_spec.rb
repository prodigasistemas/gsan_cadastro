require 'rails_helper'

describe ClienteTiposController, type: :controller do
  render_views

  let!(:esfera_poder)             { create(:esfera_poder) }
  let!(:residencial)              { create(:cliente_tipo, :pessoa_fisica, descricao: 'RESIDENCIAL') }
  let!(:assiciacoes)              { create(:cliente_tipo, :pessoa_juridica, descricao: 'ASSOCIACOES') }

  describe "GET index" do
    context "quando a consulta possuir filtros" do
      let(:params) do
        {
          "query" =>
            {
              "descricao" => "RESIDENCIAL"
            }
        }
      end

      before do
        get :index, params: params, format: :json
      end

      it "retorna a lista de tipos de cliente ativos" do
        expect(json['cliente_tipos'].size).to eq 1
        expect(json['cliente_tipos'].collect{|l| l["descricao"]}).to include(residencial.descricao)
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

      it "retorna a lista de tipos de cliente ativos" do
        expect(json['cliente_tipos'].size).to eq 2
        expect(json['cliente_tipos'].collect{|l| l["descricao"]}).to include(residencial.descricao)
      end
    end
  end

  describe "GET show" do
    it "retorna um tipo de cliente" do
      get :show, params: {id: residencial.id}, format: :json
      expect(json['descricao']).to eq residencial.descricao
    end
  end

  describe "POST create" do
    context "quando o tipo de cliente é criado com sucesso" do
      let(:params) do
        {
          'cliente_tipo' => attributes_for(
            :cliente_tipo,
            esfera_poder_id: esfera_poder.id
          ).with_indifferent_access
        }
      end

      it "cria um tipo de cliente" do
        post :create, params: params, format: :json
        expect(json['descricao']).to eq params['cliente_tipo']['descricao']
      end
    end

    context "quando o tipo de cliente não é criado" do
      let(:params) do
        {
          'cliente_tipo' => attributes_for(:cliente_tipo).with_indifferent_access
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
    context "quando o tipo de cliente é atualizado com sucesso" do
      let(:params) {
        attributes_for(
          :cliente_tipo,
          esfera_poder_id: esfera_poder.id
        ).with_indifferent_access
      }

      it "altera o tipo de cliente" do
        put :update, params: {id: residencial, cliente_tipo: params}, format: :json
        expect(response.status).to eq 200
      end
    end

    context "quando o tipo de cliente não é atualizado" do
      let(:params) {
        attributes_for(:cliente_tipo, descricao: nil).with_indifferent_access
      }

      it "retorna erros" do
        put :update, params: {id: 1, cliente_tipo: params}, format: :json
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end
end