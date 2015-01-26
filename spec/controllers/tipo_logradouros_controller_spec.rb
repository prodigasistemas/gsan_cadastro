require 'rails_helper'

describe TipoLogradourosController, type: :controller do
  render_views

  describe "GET index" do
    let!(:tipos) { create_list(:tipo_logradouro, 2) }

    it "retorna lista de tipos de logradouros" do
      get :index, format: :json
      expect(json.size).to eq tipos.size
    end
  end
end