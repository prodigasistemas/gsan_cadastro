require 'rails_helper'

describe ContratosMedicaoController, type: :controller do
  render_views

  let!(:contrato)  { create(:contrato_medicao) }

  describe "GET index" do
    context "recupera a empresa cadastrada" do
      before do
        get :index
      end

      it "retorna a lista de contratos" do
        expect(json['contratos'].size).to eq 1
        expect(json['contratos'].collect{|l| l["numero"]}).to include(contrato.numero)
      end
    end
  end
end