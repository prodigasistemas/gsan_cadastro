require 'rails_helper'

describe MunicipiosController, type: :controller do
  render_views

  let!(:belem)                    { create(:municipio, nome: 'BELEM') }
  let!(:santarem)                 { create(:municipio, nome: 'SANTAREM') }
  let!(:regiao_desenvolvimento)   { create(:regiao_desenvolvimento) }
  let!(:micro_regiao)             { create(:micro_regiao) }
  let!(:uf)                       { create(:unidade_federacao) }

  describe "GET index" do
    context "quando a consulta possuir filtros" do
      let(:params) do
        {
          "query" =>
            {
              "nome" => "BELEM"
            }
        }
      end

      before do
        get :index, params: params, format: :json
      end

      it "retorna a lista de municípios ativos" do
        expect(json['municipios'].size).to eq 1
        expect(json['municipios'].collect{|l| l["nome"]}).to include(belem.nome)
      end

      it "retorna dados da paginação" do
        expect(json['page']['first_page']).to be true
        expect(json['page']['last_page']).to be true
        expect(json['page']['current_page']).to eq(1)
        expect(json['page']['total']).to eq(1)
        expect(json['page']['total_pages']).to eq(1)
      end
    end

    context "quando a consulta não possuir filtros" do
      before do
        get :index, params: nil, format: :json
      end

      it "retorna a lista de municípios ativos" do
        expect(json['municipios'].size).to eq 2
        expect(json['municipios'].collect{|l| l["nome"]}).to include(belem.nome)
      end
    end
  end

  describe "GET show" do
    it "retorna um município" do
      get :show, params: {id: belem.id}, format: :json
      expect(json['nome']).to eq belem.nome
    end
  end

  describe "POST create" do
    context "quando o município é criado com sucesso" do
      let(:params) do
        {
          'municipio' => attributes_for(
            :municipio,
            micro_regiao_id: micro_regiao.id,
            regiao_desenvolvimento_id: regiao_desenvolvimento.id,
            uf_id: uf.id
          ).with_indifferent_access
        }
      end

      it "cria um município" do
        post :create, params: params, format: :json
        expect(json['nome']).to eq params['municipio']['nome']
      end
    end

    context "quando o município não é criado" do
      let(:params) do
        {
          'municipio' => attributes_for(:municipio).with_indifferent_access
        }
      end

      it "mostra erros de validação" do
        post :create, params: params, format: :json
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end

  describe "PUT update" do
    context "quando o município é atualizado com sucesso" do
      let(:params) {
        attributes_for(
          :municipio,
          micro_regiao_id: micro_regiao.id,
          regiao_desenvolvimento_id: regiao_desenvolvimento.id,
          uf_id: uf.id
        ).with_indifferent_access
      }

      it "retorna o município" do
        put :update, params: {id: belem, municipio: params}, format: :json
        belem.reload
        expect(json['nome']).to eq belem.nome
      end
    end

    context "quando o município não é atualizado" do
      let(:params) {
        attributes_for(:municipio, nome: nil).with_indifferent_access
      }

      it "retorna erros" do
        put :update, params: {id: 1, municipio: params}, format: :json
        expect(response.status).to eq 422
        expect(json['errors']).to_not be_nil
      end
    end
  end
end