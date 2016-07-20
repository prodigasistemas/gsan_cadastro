require 'rails_helper'

describe AbrangenciasController, type: :controller do
  describe "POST create" do
    let!(:contrato_medicao) { create(:contrato_medicao) }
    let!(:imovel_1) { create(:imovel) }
    let!(:imovel_2) { create(:imovel) }

    context "dados validos de autenticacao" do
      let(:params) do
        {
          "contrato_medicao_id"  => contrato_medicao.id,
          "imoveis" => [imovel_1.id, imovel_2.id]
        }
      end

      before do
        post :create, params
      end

      it "autenticacao realizada com sucesso" do
        expect(response).to be_success
        body = JSON.parse(response.body)
        expect(body['entidades'].size).to eql(2)
        expect(body['entidades'].first["id"]).to eql(imovel_1.atributos["id"])
        expect(body['entidades'].last["id"]).to eql(imovel_2.atributos["id"])
      end
    end
  end
end