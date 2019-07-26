require 'rails_helper'

describe AssociacoesController, type: :controller do
  let!(:empresa) { create(:empresa, nome: "empresa") }
  let!(:contrato_medicao1) { create(:contrato_medicao, numero: "847-ABC", empresa: empresa) }
  let!(:contrato_medicao2) { create(:contrato_medicao, numero: "123", empresa: empresa) }
  let!(:contrato_medicao3) { create(:contrato_medicao, numero: "432") }

  describe "GET index - has_many" do
    context "associacao válida" do
      before do
        get :index, params: {objeto: "empresa", objeto_id: empresa.id, associacao: "contrato_medicoes"}
      end

      it{ expect(json["entidades"]).to_not be_empty }
      it{ expect(json["entidades"].collect{|l| l["numero"]}).to include(contrato_medicao1.numero) }
      it{ expect(json["entidades"].collect{|l| l["numero"]}).to include(contrato_medicao2.numero) }
      it{ expect(json["entidades"].collect{|l| l["numero"]}).to_not include(contrato_medicao3.numero) }
    end

    context "model não existente" do
      before do
        get :index, params: {objeto: "bah", objeto_id: empresa.id, associacao: "imovel"}
      end

      it{ expect(response).to be_bad_request }
      it{ expect(json["error"]).to eq "Não existe model bah" }
    end

    context "associacao não existente" do
      before do
        get :index, params: {objeto: "empresa", objeto_id: empresa.id, associacao: "coeficientes"}
      end

      it{ expect(response).to be_bad_request }
      it{ expect(json["error"]).to eq "Não existe associacao coeficientes para empresa" }
    end

    context "parametro invalido" do
      before do
        get :index, params: {objeto: "empresa", objeto_id: empresa.id, associacao: "delete"}
      end

      it{ expect(response).to be_bad_request }
      it{ expect(json["error"]).to eq "Parametro inválido" }
    end
  end

  describe "GET index - belons_to/has_one" do
    context "associacao válida" do
      before do
        get :index, params: {objeto: "contrato_medicao", objeto_id: contrato_medicao1.id, associacao: "empresa"}
      end

      it{ expect(json["entidade"]).to_not be_nil }
      it{ expect(json["entidade"]["nome"]).to eq empresa.nome }
    end
  end
end