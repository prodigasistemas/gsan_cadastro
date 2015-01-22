require 'rails_helper'

describe MicroRegioesController, type: :controller do
  render_views

  describe "GET index" do
    let!(:marajo) { create(:micro_regiao, nome: 'MARAJO') }
    let!(:tapajos) { create(:micro_regiao, nome: 'TAPAJOS') }
    let!(:tocantis) { create(:micro_regiao, nome: 'TOCANTINS', ativo: 2) }

    it "retorna a lista de micro regiões ativas" do
      get :index, format: :json

      expect(json.size).to eq 2
      expect(json.collect{|l| l["nome"]}).to include(marajo.nome)
    end
  end

  describe "GET show" do
    it "retorna uma micro região" do
      get :show, id: marajo.id, format: :json
      expect(json['nome']).to eq marajo.nome
    end
  end

  describe "POST create" do
    let!(:regiao) { create(:regiao) }

    context "quando micro região é criada com sucesso" do
      let(:params) do
        {
          'micro_regiao'=>attributes_for(:micro_regiao, regiao_id: regiao.id).with_indifferent_access
        }
      end

      it "cria uma micro região" do
        post :create, params, format: :json
        expect(json['nome']).to eq params['micro_regiao']['nome']
      end
    end

    context "quando micro região não é criada" do
      let(:params) do
        {
          'micro_regiao'=>attributes_for(:micro_regiao).with_indifferent_access
        }
      end

      it "mostra erros de validação" do
        post :create, params, format: :json
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end

end