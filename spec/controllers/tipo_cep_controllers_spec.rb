require 'rails_helper'

describe CepTiposController, type: :controller do
  render_views

  describe "GET index" do
    let!(:tipos) { [create(:cep_tipo), create(:cep_tipo, descricao: 'Um qualquer')] }

    context "quando a consulta não possuir filtros" do
      it "retorna lista de tipos de ceps" do
        get :index, format: :json
        expect(json['cep_tipos'].size).to eq tipos.size
      end
    end

    context "quando a consulta possuir filtros" do
      let(:params) do
        {
          "query" =>
            {
              "descricao" => tipos.first.descricao
            }
        }
      end

      before do
        get :index, params: params, format: :json
      end

      it "retorna a lista de tipos de ceps" do
        expect(json['cep_tipos'].size).to eq 1
        expect(json['cep_tipos'].collect{|l| l["descricao"]}).to include(tipos.first.descricao)
      end

      it_behaves_like "com dados da paginacao"
    end
  end

  describe "GET show" do
    let!(:cep_tipo) { create(:cep_tipo) }

    it "retorna um tipo de cep" do
      get :show, params: {id: cep_tipo}, format: :json
      expect(json['descricao']).to eq cep_tipo.descricao
    end
  end

  describe "POST create" do

    before do
      post :create, params: params, format: :json
    end

    context "quando um tipo de cep é criado com sucesso" do
      let(:params) do
        {
          'cep_tipo' => attributes_for(:cep_tipo).with_indifferent_access
        }
      end

      it "cria uma tipo  de cep" do
        expect(json['descricao']).to eq params['cep_tipo']['descricao']
      end
    end

    context "quando a região de desenvolvimento não é criada" do
      let(:params) do
        {
          'cep_tipo' => attributes_for(:cep_tipo, descricao: nil).with_indifferent_access
        }
      end

      it "retorna erros de validações" do
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end

  describe "PUT update" do
    let!(:cep_tipo) { create(:cep_tipo) }

    before do
      put :update, params: {id: cep_tipo, cep_tipo: params}, format: :json
    end

    context "quando cep tipo é atualiado com sucesso" do
      let(:params) {
        attributes_for(:cep_tipo, descricao: 'EMPRESARIAL').with_indifferent_access
      }

      it "atualiza o tipo de cep" do
        expect(json['descricao']).to eq params['descricao']
      end
    end

    context "quando tipo de cep não é atualizado com sucesso" do
      let(:params) {
        attributes_for(:cep_tipo, descricao: nil).with_indifferent_access
      }

      it "mostra erros" do
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end
end