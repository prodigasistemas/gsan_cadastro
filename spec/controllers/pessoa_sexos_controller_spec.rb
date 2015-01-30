require 'rails_helper'

describe PessoaSexosController, type: :controller do
  render_views

  describe "GET index" do
    let!(:sexos) { create_list(:pessoa_sexo, 2) }

    it "retorna lista de tipos de sexos" do
      get :index, format: :json
      expect(json["pessoa_sexos"].size).to eq sexos.size
    end
  end
end
