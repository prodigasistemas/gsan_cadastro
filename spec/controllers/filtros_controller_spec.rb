require 'rails_helper'

describe FiltrosController, type: :controller do
  let!(:empresa){ create(:empresa, nome: "cosanpa") }

  describe "GET index" do
    context "filtro válido" do
      before do
        get :index, tipo: "empresa", filtros: { nome: "cosa" }
      end

      it{ expect(json["entidades"]).to_not be_empty }
      it{ expect(json["entidades"].first["nome"]).to eq empresa.nome }
    end

    context "filtro inválido" do
      before do
        get :index, tipo: "teste", filtros: { nome: "cosa" }
      end

      it{ expect(json["error"]).to eq "Tipo não existente" }
    end

    context "entidade não filtrável" do
      before do
        get :index, tipo: "pessoa_sexo", filtros: { nome: "cosa" }
      end

      it{ expect(json["error"]).to eq "Não é possível filtrar pessoa_sexo" }
    end

    context "atributos inválidos" do
      before do
        get :index, tipo: "empresa"
      end

      it{ expect(json["error"]).to eq "Atributos de busca inválidos" }
    end
  end
end