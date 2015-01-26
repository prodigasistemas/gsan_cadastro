require 'rails_helper'

describe UnidadeFederacoesController, type: :controller do
  render_views

  describe "GET index" do
    let!(:unidades) { create_list(:unidade_federacao, 2) }

    it "retorna lista de unidades federacao" do
      get :index, format: :json
      expect(json.size).to eq unidades.size
    end
  end
end