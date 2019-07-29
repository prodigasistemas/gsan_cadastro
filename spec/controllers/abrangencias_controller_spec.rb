require 'rails_helper'

describe AbrangenciasController, type: :controller do
  describe "POST create" do
    let!(:contrato_medicao) { create(:contrato_medicao) }
    let!(:imovel_1) { create(:imovel) }
    let!(:imovel_2) { create(:imovel) }
    let!(:ligacao_agua_situacao) { create(:ligacao_agua_situacao) }
    let!(:conta1) { create(:conta, imovel: imovel_1, ligacao_agua_situacao_id: ligacao_agua_situacao.id, ano_mes_referencia: '201601') }
    let!(:conta2) { create(:conta, imovel: imovel_2, ligacao_agua_situacao_id: ligacao_agua_situacao.id, ano_mes_referencia: '201601') }

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
        post :create, params: params
      end

      it {
        expect(response).to be_successful
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

        expect(response).to be_successful
        expect(json['entidades'].size).to eq(2)
      end
    end

    describe "search" do
      it do
        get :index, params: {query: {imovel_id: imovel_1.id}}

        expect(response).to be_successful
        expect(json['entidades'].size).to eq(1)
        expect(json['entidades'].first["id"]).to eq(abrangencia_1.id)
        expect(json['entidades'].first["imovel_id"]).to eq(imovel_1.id)
      end
    end
  end
end