require 'rails_helper'

describe EmpresasController, type: :controller do
  render_views

  let!(:empresa)  { create(:empresa) }

  describe "GET index" do
    context "consulta empresas" do

      before do
        get :index
      end

      it "retorna a lista de empresas" do
        expect(json['entidades'].size).to eq 1
        expect(json['entidades'].collect{|l| l["nome"]}).to include(empresa.nome)
      end
    end
  end
end