require "rails_helper"

describe CepTipo do
  describe "validacoes" do
    it { should validate_uniqueness_of :descricao }
    it { should validate_presence_of :descricao }
    it { should validate_length_of(:descricao).is_at_most(20) }
  end

  describe "scopes" do
    let!(:ativo)    { create(:cep_tipo) }
    let!(:inativo)  { create(:cep_tipo, descricao: 'EMPRESA', ativo: false) }

    describe ".ativo" do
      it "retorna tipos de CEPs ativos" do
        expect(CepTipo.ativo).to     include ativo
        expect(CepTipo.ativo).to_not include inativo
      end
    end
  end
end
