require 'rails_helper'

describe MedicaoPerformancesController, type: :controller do

  describe "GET" do
    let!(:localidade)          { create(:localidade)}
    let!(:setor_comercial)     { create(:setor_comercial)}
    let!(:imovel)              { create(:imovel, localidade: localidade, setor_comercial: setor_comercial) }
    let!(:contrato_medicao)    { create(:contrato_medicao)}
    let!(:medicao_performance) { create(:medicao_performance, contrato_medicao: contrato_medicao, imovel: imovel) }

    describe "search" do
      it {
        params = {referencia: 201601, contrato_medicao_id: contrato_medicao.id}
        
        get :index, params

        expect(response).to be_success
        expect(json['entidades'].size).to eq(1)
      }
    end

    describe "search with localidade" do
      it {
        params = {referencia: 201601, contrato_medicao_id: contrato_medicao.id, localidade_id: localidade.id}
        
        get :index, params

        expect(response).to be_success
        expect(json['entidades'].size).to eq(1)
      }
    end
  end  
end
