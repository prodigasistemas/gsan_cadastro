require 'rails_helper'

describe ContratosMedicaoController, type: :controller do
  render_views

  let!(:contrato) { create(:contrato_medicao) }
  let!(:empresa)  { create(:empresa) }

  describe "GET index" do
    context "recupera a empresa cadastrada" do
      before do
        get :index
      end

      it "retorna a lista de contratos" do
        expect(json['contratos'].size).to eq 1
        expect(json['contratos'].collect{|l| l["numero"]}).to include(contrato.numero)
        expect(json['contratos'].collect{|l| l["numero"]}).to include(contrato.numero)
      end
    end
  end

  describe "GET show" do
    it "retorna apenas um contrato" do
      get :show, id: contrato.id, format: :json
      expect(json['numero']).to eq contrato.numero
    end
  end

  describe "POST create" do
    context "quando o contrato é criado com sucesso" do
      let(:params) do
        {
          'contrato' => attributes_for(
            :contrato_medicao,
            empresa_id: empresa.id
          ).with_indifferent_access
        }
      end

      it "cadastra um novo contrato" do
        post :create, params, format: :json
        expect(json['numero']).to eq params['contrato']['numero']
      end
    end
  end  
end