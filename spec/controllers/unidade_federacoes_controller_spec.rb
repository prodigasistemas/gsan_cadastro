require 'rails_helper'

describe UnidadeFederacoesController, type: :controller do
  render_views

  describe "GET index" do
    let!(:unidades) { create_list(:unidade_federacao, 2) }

    context "quando a consulta não possuir filtros" do
      it "retorna lista de tipos de ceps" do
        get :index, format: :json
        expect(json['unidade_federacoes'].size).to eq unidades.size
      end
    end

    context "quando a consulta possuir filtros" do
      let(:params) do
        {
          "query" =>
            {
              "descricao" => unidades.first.descricao,
              "sigla" => unidades.first.sigla
            }
        }
      end

      before do
        get :index, params: params, format: :json
      end

      it "retorna a lista de unidades de federações" do
        expect(json['unidade_federacoes'].size).to eq 1
        expect(json['unidade_federacoes'].collect{|l| l["descricao"]}).to include(unidades.first.descricao)
      end

      it_behaves_like "com dados da paginacao"
    end
  end

  describe "GET show" do
    let!(:unidade_federacao) { create(:unidade_federacao) }

    it "retorna uma unidade de federação" do
      get :show, params: {id: unidade_federacao}, format: :json
      expect(json['descricao']).to eq unidade_federacao.descricao
    end
  end

  describe "POST create" do
    before do
      post :create, params: params, format: :json
    end

    context "quando a unidade de federação é criada com sucesso" do
      let(:params) do
        {
          'unidade_federacao' => attributes_for(:unidade_federacao).with_indifferent_access
        }
      end

      it "cria uma unidade de federação" do
        expect(json['descricao']).to eq params['unidade_federacao']['descricao']
      end
    end

    context "quando a unidade da federação não é criada" do
      let(:params) do
        {
          'unidade_federacao' => attributes_for(:unidade_federacao, descricao: '').with_indifferent_access
        }
      end

      it_behaves_like "erros de validacao controllers"
    end
  end

  describe "PUT update" do
    let!(:unidade_federacao) { create(:unidade_federacao) }

    before do
      put :update, params: {id: unidade_federacao, unidade_federacao: params}, format: :json
    end

    context "quando cep tipo é atualiado com sucesso" do
      let(:params) {
        attributes_for(:unidade_federacao, descricao: 'MINHA UNIDADE', sigla: 'MU').with_indifferent_access
      }

      it "atualiza a unidade de federação" do
        expect(json['descricao']).to eq params['descricao']
      end
    end

    context "quando unidade de federação não é atualizado com sucesso" do
      let(:params) {
        attributes_for(:unidade_federacao, descricao: nil).with_indifferent_access
      }

      it_behaves_like "erros de validacao controllers"
    end
  end
end