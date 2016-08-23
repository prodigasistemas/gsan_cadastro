require 'rails_helper'

describe AbrangenciasController, type: :controller do
  describe "POST create" do
    let!(:contrato_medicao) { create(:contrato_medicao) }
    let!(:imovel_1) { create(:imovel) }
    let!(:imovel_2) { create(:imovel) }

    context "success" do
      let(:params) do
        {
          "contrato_medicao_id"  => contrato_medicao.id,
          "query" => {
            "localidade_id" => "1"
          }
        }
      end

      before do
        post :create, params
      end

      it {
        expect(response).to be_success
        expect(json['entidade']).to_not be_nil
      }
    end
  end

  describe "GET" do
    let!(:imovel_1) { create(:imovel) }
    let!(:abrangencia_1) { create(:abrangencia, imovel: imovel_1) }
    let!(:abrangencia_2) { create(:abrangencia) }

    describe "index" do
      it 'all' do
        get :index

        expect(response).to be_success
        expect(json['entidades'].size).to eq(2)
      end
    end

    describe "search" do
      it {
        params = {query: {imovel_id: imovel_1.id}}
        get :index, params

      expect(response).to be_success
      expect(json['entidades'].size).to eq(1)
      expect(json['entidades'].first["id"]).to eq(abrangencia_1.id)
      expect(json['entidades'].first["imovel_id"]).to eq(imovel_1.id)
      }
    end
  end
end