require 'rails_helper'

describe RegioesController, type: :controller do
  render_views

  describe "GET index" do
    let!(:regioes) { [create(:regiao), create(:regiao, nome: 'CENTRO', ativo: 2)] }

    it "retorna todas as regiões ativas" do
      get :index, format: :json
      expect(json.size).to eq 1
      expect(json.collect{|l| l["nome"]}).to include(regioes.first.nome)
    end
  end
end