require 'rails_helper'

describe ContratoMedicoesController, type: :controller do
  render_views

  let!(:contrato) { create(:contrato_medicao) }
  let!(:empresa)  { create(:empresa) }

  describe "GET index" do
    context "recupera a empresa cadastrada" do
      before do
        get :index
      end

      it "retorna a lista de contratos" do
        expect(json['entidades'].size).to eq 1
        expect(json['entidades'].collect{|l| l["numero"]}).to include(contrato.numero)
      end
    end
  end

  describe "GET show" do
    it "retorna apenas um contrato" do
      get :show, params: {id: contrato.id}, format: :json
      expect(json['entidade']['numero']).to eq contrato.numero
    end
  end

  describe "POST create" do
    context "quando o contrato é criado com sucesso" do
      let(:params) do
        {
          'contrato_medicao' => attributes_for(
            :contrato_medicao,
            numero: "20160102",
            empresa_id: empresa.id
          ).with_indifferent_access
        }
      end

      it "cadastra um novo contrato" do
        post :create, params: params, format: :json
        expect(json['entidade']['numero']).to eq params['contrato_medicao']['numero']
      end
    end

    context "quando o contrato nao é criado" do
      let(:params) {
        {
          'contrato_medicao'=>attributes_for(:contrato_medicao, numero: '').with_indifferent_access
        }
      }

      it "retorna erros" do
        post :create, params: params, format: :json
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end

  describe "PUT update" do
    context "quando o contrato é atualizado com sucesso" do
      let(:params) {
        attributes_for(:contrato_medicao).with_indifferent_access
      }

      it "retorna o contrato" do
        put :update, params: {id: 1, contrato_medicao: params}, format: :json
        expect(response).to be_successful
      end
    end

    context "quando contrato não é atualizado" do
      let(:params) {
        attributes_for(:contrato_medicao, numero: '').with_indifferent_access
      }

      it "retorna erros" do
        put :update, params: {id: 1, contrato_medicao: params}, format: :json
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end
end