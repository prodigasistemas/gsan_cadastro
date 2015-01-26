require 'rails_helper'

describe TituloLogradourosController, type: :controller do
  render_views

  describe "GET index" do
    let!(:titulos) { create_list(:titulo_logradouro, 2) }

    it "retorna lista de títulos de logradouros" do
      get :index, format: :json
      expect(json.size).to eq titulos.size
    end
  end
end