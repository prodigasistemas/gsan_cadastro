require 'rails_helper'

describe ProfissoesController, type: :controller do
  render_views

  describe "GET index" do
    let!(:profissoes) { create_list(:profissao, 2) }

    it "retorna lista de profissoes" do
      get :index, format: :json
      expect(json.size).to eq profissoes.size
    end
  end
end