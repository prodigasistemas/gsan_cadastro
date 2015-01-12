require "rails_helper"

describe CepTipo do
  describe "scopes" do
    let!(:ativo)    { create(:cep_tipo) }
    let!(:inativo)  { create(:cep_tipo, ativo: false) }

    describe ".ativo" do
      it "retorna tipos de CEPs ativos" do
        expect(CepTipo.ativo).to     include ativo
        expect(CepTipo.ativo).to_not include inativo
      end
    end
  end
end
