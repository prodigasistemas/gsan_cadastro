require 'rails_helper'

describe RegioesController, type: :controller do
  render_views

  describe "GET index" do
    let!(:regioes) { [create(:regiao), create(:regiao, nome: 'CENTRO', ativo: 2)] }

    context "quando a consulta possuir filtros" do
      let(:params) do
        {
          "query"=>{ "nome"=>"NORTE" }
        }
      end

      before do
        get :index, params, format: :json
      end

      it "retorna a lista de regiões de acordo com os dados dos filtros" do
        expect(json['regioes'].size).to eq 1
        expect(json['regioes'].collect{|l| l["nome"]}).to include(regioes.first.nome)
      end

      it_behaves_like "com dados da paginacao"
    end

    context "quando a consulta não possuir filtros" do
      it_behaves_like "sem dados da paginacao"
    end
  end

  describe "POST create" do

    before do
      post :create, params, format: :json
    end

    context "quando região é criada com sucesso" do
      let(:params) do
        {
          'regiao'=>attributes_for(:regiao).with_indifferent_access
        }
      end

      it "cria uma região" do
        expect(json['nome']).to eq params['regiao']['nome']
      end
    end

    context "quando região não é criada" do
      let(:params) do
        {
          'regiao'=>attributes_for(:regiao, nome: '').with_indifferent_access
        }
      end

      it "mostra erros de validação" do
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end

  describe "GET show" do
    let!(:regiao) { create(:regiao) }

    it "retorna uma regiao" do
      get :show, id: regiao.id, format: :json
      expect(json['nome']).to eq regiao.nome
    end
  end

  describe "PUT update" do
    let!(:regiao) { create(:regiao) }

    context "quando a região é atualizada com sucesso" do
      let(:params) {
        attributes_for(:regiao).with_indifferent_access
      }

      it "retorna a região" do
        put :update, id: regiao, regiao: params, format: :json
        regiao.reload
        expect(json['nome']).to eq regiao.nome
      end
    end

    context "quando a região não é atualizada" do
      let(:params) {
        attributes_for(:regiao, nome: '').with_indifferent_access
      }

      it "retorna erros" do
        put :update, id: regiao, regiao: params, format: :json
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end
end