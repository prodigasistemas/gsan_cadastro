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
        expect(json['entidade']['imoveis'].size).to eq 2
      end
    end
  end
end