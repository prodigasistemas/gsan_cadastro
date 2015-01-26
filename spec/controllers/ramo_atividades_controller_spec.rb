require 'rails_helper'

describe RamosAtividadesController, type: :controller do
  render_views

  describe "GET index" do
    let!(:ramo_atividades) { create_list(:ramo_atividade, 2) }

    it "retorna lista de ramos de atividades" do
      get :index, format: :json
      expect(json.size).to eq ramo_atividades.size
    end
  end
end