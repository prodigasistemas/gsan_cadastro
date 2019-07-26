require 'rails_helper'

describe BairrosController, type: :controller do
  render_views

  let!(:jurunas)                  { create(:bairro, nome: 'JURUNAS') }
  let!(:guama)                    { create(:bairro, nome: 'GUAMA') }
  let!(:municipio)                { create(:municipio) }

  describe "GET index" do
    context "quando a consulta possuir filtros" do
      let(:params) do
        {
          "query" =>
            {
              "nome" => "JURUNAS"
            }
        }
      end

      before do
        get :index, params: params, format: :json
      end

      it "retorna a lista de bairros ativos" do
        expect(json['bairros'].size).to eq 1
        expect(json['bairros'].collect{|l| l["nome"]}).to include(jurunas.nome)
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

      it "retorna a lista de bairros ativos" do
        expect(json['bairros'].size).to eq 2
        expect(json['bairros'].collect{|l| l["nome"]}).to include(jurunas.nome)
      end
    end
  end

  describe "GET show" do
    it "retorna um bairro" do
      get :show, params: {id: jurunas.id}, format: :json
      expect(json['nome']).to eq jurunas.nome
    end
  end

  describe "POST create" do
    context "quando o bairro é criado com sucesso" do
      let(:params) do
        {
          'bairro' => attributes_for(
            :bairro,
            municipio_id: municipio.id
          ).with_indifferent_access
        }
      end

      it "cria um bairro" do
        post :create, params: params, format: :json
        expect(json['nome']).to eq params['bairro']['nome']
      end
    end

    context "quando o bairro não é criado" do
      let(:params) do
        {
          'bairro' => attributes_for(:bairro).with_indifferent_access
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
    context "quando o bairro é atualizado com sucesso" do
      let(:params) {
        attributes_for(
          :bairro,
          municipio_id: municipio.id
        ).with_indifferent_access
      }

      it "retorna o bairro" do
        put :update, params: {id: jurunas, bairro: params}, format: :json
        jurunas.reload
        expect(json['nome']).to eq jurunas.nome
      end
    end

    context "quando o bairro não é atualizado" do
      let(:params) {
        attributes_for(:bairro, nome: nil).with_indifferent_access
      }

      it "retorna erros" do
        put :update, params: {id: 1, bairro: params}, format: :json
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end
end